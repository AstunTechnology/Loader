#!/usr/bin/python

## Copyright (c) 2011 Astun Technology

## Permission is hereby granted, free of charge, to any person obtaining a copy
## of this software and associated documentation files (the "Software"), to deal
## in the Software without restriction, including without limitation the rights
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
## copies of the Software, and to permit persons to whom the Software is
## furnished to do so, subject to the following conditions:

## The above copyright notice and this permission notice shall be included in
## all copies or substantial portions of the Software.

## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
## THE SOFTWARE.

"""Simple OS MasterMap GML/GZ loader making use of OGR 1.8 """

from __future__ import with_statement
import sys, os, shutil
import datetime
import shlex, subprocess
from string import Template

class OsmmLoader:

  def __init__ (self, config):
    # Read configuraton
    self.config = config
    self.status = (0, '')
    try:
        self.src_dir = config['src_dir']
        self.tmp_dir = config['tmp_dir']
        self.prep_cmd = config['prep_cmd']
        self.ogr_cmd = config['ogr_cmd']
        self.gfs_file = config['gfs_file']
        if 'out_dir' in config:
          self.out_dir = config['out_dir']
        if 'standalone' in config:
          self.standalone = config['standalone']
        else:
          self.standalone = True
          
    except KeyError, key:
        if not self.standalone:
          self.status = (1, 'Missing configuration value:' + key)
          return self
        else:
          print 'Missing configuration value:', key
          exit(1)
    self.debug = config.get('debug')
    retVal = self.setup()
    if retVal:
      self.load()
    self.cleanup()

  def setup(self):
    # Determine if we are in debug mode
    self.debug =  (str(self.debug).lower() == 'true')
    if self.debug:
        print 'Config:', self.config
    # Check that a valid gfs is file specified
    if not os.path.isfile(self.gfs_file):
        self.gfs_file = None
        print 'No valid gfs file found, output schema and geometry types will be determed dynamically by OGR'
    # Check for the existence of the GDAL_DATA environment
    # variable required by ogr2ogr
    if not 'GDAL_DATA' in os.environ:
        if not self.standalone:
            self.status = (1, 'Please ensure that the GDAL_DATA environment variable is set and try again')
            return False
        else:
            print 'Please ensure that the GDAL_DATA environment variable is set and try again'
            exit(1)
    # Create a temp directory as a child to the temp
    # directory specified to hold all of our working
    # files and to make cleaning up simple
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    self.tmp_dir = os.path.join(self.tmp_dir, 'osmmloader_' + timestamp)
    try:
      os.mkdir(self.tmp_dir)
    except OSError:
      if not self.standalone:
        self.status = (1, 'Could not create temp directory: ' + self.tmp_dir)
        return False
      else:
        print 'Could not create temp directory: ', self.tmp_dir
        exit(1)
    return True

  def cleanup(self):
    if not self.debug:
        try:
          shutil.rmtree(self.tmp_dir)
        except OSError:
          if not self.standalone:
            self.status = (1, 'Could not remove temp directory: ' + self.tmp_dir + '. You may need to delete it yourself')
            return
          else:
            print 'Could not remove temp directory: ', self.tmp_dir, '. You may need to delete it yourself'
            exit(1)
            
  def getStatus(self):
    return self.status

  def load (self):
    # Create string templates for the commands
    prep_cmd = Template(self.prep_cmd)
    ogr_cmd = Template(self.ogr_cmd)
    num_files = 0
    for root, dirs, files in os.walk(self.src_dir):
        for name in files:
            file_parts = os.path.splitext(name)
            ext = file_parts[1].lower()
            if ext in ['.gz', '.gml']:
                file_path = os.path.join(root, name)
                print "Processing: %s" % file_path
                # Run the script to prepare the GML
                prepared_file = os.path.join(self.tmp_dir, file_parts[0] + '.prepared')
                if self.debug:
                    print 'Prepared file:', prepared_file
                prep_args = shlex.split(prep_cmd.substitute(file_path='\'' + file_path + '\''))
                if self.debug:
                    print 'Prep command:', ' '.join(prep_args)
                f = open(prepared_file, 'w')
                sErr = open(os.devnull, 'w')
                sIn = open(os.devnull, 'r')
                rtn = subprocess.call(prep_args, stdout=f, stderr=sErr, stdin=sIn)
                sErr.close()
                sIn.close()
                f.close()
                if rtn != 0 and not self.standalone:
                  self.status = (1, 'Processing stage failed with code ' + str(rtn))
                  return
                # Copy over the template gfs file used by ogr2ogr
                # to read the GML attributes, determine the geometry type etc.
                # Using a template so we have control over the geometry type
                # for each table
                if self.gfs_file:
                    shutil.copy(self.gfs_file, os.path.join(self.tmp_dir, file_parts[0] + '.gfs'))
                # Run OGR
                print "Loading: %s" % file_path
                
                # This will set the out_path only if $out_path is present
                self.out_dir = os.path.join(self.out_dir, file_parts[0])
                ogr_cmd = Template( ogr_cmd.safe_substitute(out_path='\'' + self.out_dir + '\'') )
                
                ogr_args = shlex.split(ogr_cmd.substitute(file_path='\'' + prepared_file + '\''))
                if self.debug:
                    print 'OGR command:', ' '.join(ogr_args)
                rtn = subprocess.call(ogr_args)
                if rtn != 0 and not self.standalone:
                  self.status = (1, 'Conversion stage failed with code ' + str(rtn))
                  return
                # Increment the file count
                num_files += 1
                if not self.debug:
                  # Clean up by deleting the temporary prepared file
                  os.remove(prepared_file)
    print "Loaded %i file%s" % (num_files, '' if num_files == 1 else 's')

def main():
  if len(sys.argv) < 2:
    print 'usage: python osmmloader.py osmmloader.config [key=value]'
    sys.exit(1)
  config_file = sys.argv[1]
  if os.path.exists(config_file):
	# Build a dict of configuration
    with open(config_file, 'r') as f:
      config = dict([line.replace('\n','').split('=',1) for line in f.readlines() if len(line.replace('\n','')) and line[0:1] != '#'])
    # Build a dict of arguments passed on the command line that
    # override those in the config file
    overrides = dict([arg.split('=',1) for arg in sys.argv[2:]])
    config.update(overrides)
    loader = OsmmLoader(config)
  else:
    print 'Could not find config file:', config_file


if __name__ == '__main__':
  main()
