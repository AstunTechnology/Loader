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

import sys, os, shutil
import datetime
import shlex, subprocess
from string import Template

class OsmmLoader:

  def __init__ (self, config):
    # Read configuraton
    try:  
        self.src_dir = config['src_dir']
        self.tmp_dir = config['tmp_dir']
        self.prep_cmd = config['prep_cmd']
        self.ogr_dir = config['ogr_dir']
        self.ogr_cmd = config['ogr_cmd']
    except KeyError, key:
        print 'Missing configuration value:', key
        exit(1)
    self.setup()
    self.load()
    self.cleanup()

  def setup(self):
    # Check for the existence of the GDAL_DATA environment
    # variable required by ogr2ogr
    if not 'GDAL_DATA' in os.environ:
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
      print 'Could not create temp directory: ', self.tmp_dir
      exit(1)

  def cleanup(self):
    try:
      shutil.rmtree(self.tmp_dir)
    except OSError:
      print 'Could not remove temp directory: ', self.tmp_dir, '. You may need to delete it yourself'
      exit(1)

  def load (self):
    # Create string templates for the commands
    prep_cmd = Template(self.prep_cmd)
    ogr_cmd = Template(self.ogr_dir + self.ogr_cmd)
    num_files = 0
    for root, dirs, files in os.walk(self.src_dir):
        for name in files:
            file_parts = os.path.splitext(name)
            ext = file_parts[1].lower()
            if ext in ['.gz', '.gml']:
                file_path = "'" + os.path.join(root, name) + "'"
                print "Processing: %s" % (file_path)
                # Run the script to prepare the GML
                prepared_file = os.path.join(self.tmp_dir, file_parts[0] + '.prepared')
                prep_args = shlex.split(prep_cmd.substitute(file_path=file_path))
                f = open(prepared_file, 'w')
                rtn = subprocess.call(prep_args, stdout=f)
                f.close()
                print "Loading: %s" % (file_path)
                # Run OGR
                ogr_args = shlex.split(ogr_cmd.substitute(file_path=prepared_file))
                rtn = subprocess.call(ogr_args)
                # Increment the file count
                num_files += 1
                # Clean up by deleting the temporary prepared file
                os.remove(prepared_file)
    print "Loaded %i file%s" % (num_files, '' if num_files == 1 else 's')

def main():
  if len(sys.argv) < 2:
    print 'usage: python osmmloader.py config_file'
    sys.exit(1)
  config_file = sys.argv[1]
  if os.path.exists(config_file):
	# Build a dict of configuration
    with open(config_file, 'r') as f:
      config = dict([line.replace('\n','').split('=',1) for line in f.readlines()])
    # Build a dict of arguments passed on the command line that
    # override those in the config file
    overrides = dict([arg[2:].split('=',1) for arg in sys.argv[2:]])
    config.update(overrides)
    loader = OsmmLoader(config)
  else:
    print 'Could not find config file:', config_file


if __name__ == '__main__':
  main()
