#!/usr/bin/python

"""Simple GML/KML loader that provides an easy way of preparing the document before
   passing it to OGR for loading, handles loading a directory of files and uncompresses
   GZ/ZIP if required """

from __future__ import with_statement
import sys
import os
import shutil
import shlex
import subprocess
from string import Template
import tempfile
import copy
import multiprocessing


class LoaderError(Exception):
    def __init__(self, message=''):
        Exception.__init__(self, message)


class ConfigError(LoaderError):
    pass


class MissingConfigError(ConfigError):
    def __init__(self, key):
        Exception.__init__(self, 'Missing configuration value: %s' % key)
        self.key = key


class CreateTempDirError(IOError):
    def __init__(self, errno, strerror, filename):
        strerror = 'Could not create temp directory (%s)' % strerror.lower()
        IOError.__init__(self, errno, strerror, filename)


class RemoveTempDirError(OSError):
    def __init__(self, errno, strerror, filename):
        strerror = 'Could not remove temp directory (%s)' % strerror.lower()
        OSError.__init__(self, errno, strerror, filename)


class Loader:

    """Simple GML & KML Loader wrapping ogr2ogr.
    Usage:
        loader = Loader()
        loader.run(config)
    For a full list of config see read_config"""

    def __init__(self):
        pass

    def run(self, config):
        self.read_config(config)
        self.setup()
        self.load()
        self.cleanup()

    def read_config(self, config):
        self.config = config
        try:
            self.src_dir = config['src_dir']
            self.out_dir = config['out_dir']
            self.tmp_dir = config['tmp_dir']
            self.prep_cmd = config['prep_cmd']
            self.ogr_cmd = config['ogr_cmd']
            self.gfs_file = config['gfs_file']
        except KeyError as key:
            raise MissingConfigError(key)
        self.debug = config.get('debug')
        self.post_cmd = config.get('post_cmd')

    def setup(self):
        # Determine if we are in debug mode
        self.debug = (str(self.debug).lower() == 'true')
        if self.debug:
            print("Config: %s" % self.config)
        # Check that a valid gfs is file specified
        if not os.path.isfile(self.gfs_file):
            self.gfs_file = None
            print("No valid gfs file found, output schema and geometry types will be determined dynamically by OGR")
        # Create a temp directory as a child to the temp
        # directory specified to hold all of our working
        # files and to make cleaning up simple
        try:
            self.tmp_dir = tempfile.mkdtemp(dir=self.tmp_dir)
        except (OSError) as ex:
            raise CreateTempDirError(ex.errno, ex.strerror, self.tmp_dir)

    def cleanup(self):
        if not self.debug:
            try:
                shutil.rmtree(self.tmp_dir)
            except OSError as ex:
                raise RemoveTempDirError(ex.errno, ex.strerror, self.tmp_dir)

    def create_task(self, file_path):
        task = copy.copy(self.config)
        try:
            task['tmp_dir'] = tempfile.mkdtemp(dir=self.tmp_dir)
        except (OSError) as ex:
            raise CreateTempDirError(ex.errno, ex.strerror, self.tmp_dir)
        task['debug'] = self.debug
        task['file_path'] = file_path
        return task

    def load(self):
        num_files = 0

        tasks = []
        if os.path.isdir(self.src_dir):
            for root, dirs, files in os.walk(self.src_dir):
                for file_name in files:
                    ext = os.path.splitext(file_name)[1].lower()
                    if ext in ['.gz', '.gml', '.zip', '.kml']:
                        tasks.append(self.create_task(os.path.join(root, file_name)))
        else:
            tasks.append(self.create_task(self.src_dir))

        # Run the first task independently
        task = tasks.pop(0)
        if load_file(task):
            num_files += 1

        running = multiprocessing.Event()
        running.set()

        p = multiprocessing.Pool(initializer=init_worker, initargs=(running,))
        for success in p.imap_unordered(load_file_worker, tasks):
            if success:
                num_files += 1
        p.close()
        p.join()

        print("Loaded %i file%s" % (num_files, "" if num_files == 1 else "s"))


def init_worker(running_):
    # Place `running` in the global namespace of the worker subprocesses.
    # This allows the worker function to access `running` even though it is
    # not passed as an argument to the function.
    global running
    running = running_


def load_file_worker(config):
    if running.is_set():
        try:
            load_file(config)
        except (KeyboardInterrupt):
            running.clear()


def load_file(config):
    exit_status = 0

    file_path = config.get('file_path')
    file_name = os.path.split(file_path)[1]
    print("Processing: %s" % file_path)

    # Run the script to prepare the GML if one is defined, otherwise just
    # copy the existing file to the tmp directory
    prep_file_name = os.path.splitext(file_name)[0]
    prep_file_path = os.path.join(config.get('tmp_dir'), prep_file_name)
    if config.get('debug'):
        print("Prepared file: %s" % prep_file_path)
    if config.get('prep_cmd'):
        prep_args = shlex.split(Template(config.get('prep_cmd')).safe_substitute(file_path='\'' + file_path + '\''))
        if config.get('debug'):
            print("Prep command: %s" % " ".join(prep_args))
        with open(prep_file_path, 'w') as f:
            exit_status = subprocess.call(prep_args, stdout=f, stderr=sys.stderr)
            if exit_status is not 0:
                return False
    else:
        shutil.copy(file_path, prep_file_path)

    # Copy over the template gfs file used by ogr2ogr
    # to read the GML attributes, determine the geometry type etc.
    # Using a template so we have control over the geometry type
    # for each table
    if config.get('gfs_file'):
        shutil.copy(config.get('gfs_file'), os.path.join(config.get('tmp_dir'), prep_file_name + '.gfs'))

    # Run ogr2ogr to do the actual load
    print("Loading: %s" % file_path)
    ogr_args = shlex.split(Template(config.get('ogr_cmd')).safe_substitute(output_dir='\'' + config.get('out_dir') + '\'', base_file_name='\'' + prep_file_name + '\'', file_path='\'' + prep_file_path + '\''))
    if config.get('debug'):
        print("OGR command: %s" % " ".join(ogr_args))
    exit_status = subprocess.call(ogr_args, stderr=sys.stderr)
    if exit_status is not 0:
        return False

    # If there is a post command defined then run it,
    # commonly used to do some post processing of the
    # output created by ogr2ogr
    if config.get('post_cmd'):
        post_cmd = Template(config.get('post_cmd'))
        post_args = shlex.split(post_cmd.safe_substitute(output_dir='\'' + config.get('out_dir') + '\'', base_file_name='\'' + prep_file_name + '\'', file_path='\'' + prep_file_path + '\''))
        if config.get('debug'):
            print("Post command: %s" % " ".join(post_args))
        exit_status = subprocess.call(post_args, stderr=sys.stderr)
        if exit_status is not 0:
            return False

    if not config.get('debug'):
        # Clean up by deleting the temporary prepared file
        shutil.rmtree(config.get('tmp_dir'))

    return True


def main():
    if len(sys.argv) < 2:
        print("usage: python loader.py loader.config [key=value]")
        exit(1)
    config_file = sys.argv[1]
    if os.path.exists(config_file):
        # Build a dict of configuration expanding
        # any environment variables found in the values
        config = {}
        with open(config_file, 'rU') as f:
            for line in f.readlines():
                line = line.replace('\n', '').strip()
                if len(line) and line[0:1] != '#':
                    parts = line.split('=', 1)
                    config[parts[0]] = os.path.expandvars(parts[1])
        # Build a dict of arguments passed on the command line that
        # override those in the config file, no need to expand environment
        # variables as the shell will take care of it
        overrides = dict([arg.split('=', 1) for arg in sys.argv[2:]])
        config.update(overrides)
        # Kick off the loader with the specified configuration
        try:
            loader = Loader()
            loader.run(config)
        except (MissingConfigError, ConfigError) as ex:
            print(ex)
            exit(1)
        except (CreateTempDirError, RemoveTempDirError) as ex:
            print("%s: %s" % (ex.strerror, ex.filename))
            exit(1)
    else:
        print("Could not find config file: %s" % config_file)

if __name__ == '__main__':
    main()
