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

''' SAX parser implemenation to prepare an Ordnance Survey OS MasterMap
    GML file (.gml or .gz) so that it is ready to be loaded by OGR 1.8
    or above.
    The parser changes the srsName attribute to EPSG:27700 and
    promotes the fid attribute to a child element.
    Output is via stdout and is UTF-8 encoded.
    
    usage: python preposmm4ogr.py file.gml
'''

import sys
import os.path
import gzip
from xml.sax import make_parser
from xml.sax.handler import ContentHandler
from xml.sax import saxutils

class osmmHandler(ContentHandler):

    def __init__ (self):
        a = 0

    def startDocument(self):
        self.output('<?xml version="1.0" ?>')

    def startElement(self, name, attrs):
        tmp = '<' + name
        for (name, value) in attrs.items():
            if name == 'srsName':
                value = 'EPSG:27700'
            tmp += ' %s=%s' % (name, saxutils.quoteattr(value))
        tmp += '>'
        self.output(tmp)
        # Add a fid element if we find a fid attribute
        fid = attrs.get('fid',"")
        if len(fid) > 0:
            self.output('<fid>'  + fid + '</fid>')
        return

    def characters (self, ch):
        if len(ch.strip()) > 0:
            self.output(saxutils.escape(ch))

    def endElement(self, name):
        self.output('</' + name + '>')

    def output(self, str):
        sys.stdout.write(str.encode('utf-8'))

def main():
    if len(sys.argv) != 2:
        print 'usage: python preposmm4ogr.py gmlfile'
        sys.exit(1)
    inputfile = sys.argv[1]
    if os.path.exists(inputfile):
        parser = make_parser()
        parser.setContentHandler(osmmHandler())
        if os.path.splitext(inputfile)[1].lower() == '.gz':
            file = gzip.open(inputfile, 'r')
        else:
            # Assume non compressed gml, xml or no extension
            file = open(inputfile, 'r')
        parser.parse(file)
    else:
        print 'Could not find input file: ' + inputfile

if __name__ == '__main__':
    main()
