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

  def __init__ (self, outputToShape):
    
    a = 0
    
    self.outputToShape = outputToShape
    
    self.lastName = ''
    self.buildingTopoTerms = False
    self.topoTerms = ''
    self.qgsElement = ''
    
    # AC - define the fonts to use when rendering in QGIS
    if os.name is 'posix': 
    # Will probably need different font names
      self.fonts = ('Garamond','Arial','Roman','ScriptC')  
    elif os.name is 'nt':
      # Ordnance Survey use 
      #   'Lutheran','Normal','Light Roman','Suppressed text'
      self.fonts = ('GothicE','Monospac821 BT','Consolas','ScriptC','Arial Narrow') 
    elif os.name is 'mac':
      # Will probably need different font name
      self.fonts = ('Garamond','Arial','Roman','ScriptC') 
    
    # AC - the possible text placement positions used by QGIS   
    self.anchorPosition = ('Below Left','Left','Above Left','Below','Over',
                           'Above', 'Below Right','Right','Above Right')

  def startDocument(self):
    self.output('<?xml version="1.0" ?>')

  def startElement(self, name, attrs):
    
    self.name = name
    
    if self.buildingTopoTerms and self.topoTerms[-1] != '|':
      self.topoTerms += '|'
    
    if self.buildingTopoTerms and name != self.lastName:
      # We must now have collected all the values for a group of topo terms,
      # now output them
      outString = '<' + self.lastName + 's>'
      #outString += saxutils.escape(self.topoTerms[:-1])
      outString += self.topoTerms[:-1]
      outString += '</' + self.lastName + 's>'
      self.output(outString)
      self.buildingTopoTerms = False
      self.topoTerms = ''
      
    if self.outputToShape and ( name == 'osgb:theme' or name == 'osgb:descriptiveGroup' or name == 'osgb:descriptiveTerm' ):
      self.buildingTopoTerms = True
    
    # Create QGIS specific elements
    if name == 'osgb:orientation':
      self.qgsElement = '<qgsOrient>'
    elif name == 'osgb:anchorPosition':
      self.qgsElement = '<qgsAnchPos>'
    elif name == 'osgb:font':
      self.qgsElement = '<qgsFont>'
    
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
      
      # Create QGIS specific element content
      if self.name == 'osgb:orientation':
        self.qgsElement += str(float(ch) / 10) + '</qgsOrient>'
      elif self.name == 'osgb:anchorPosition':
        position = int(ch)
        if position < 0 or position >= len(self.anchorPosition):
          position = 4
        posString = self.anchorPosition[position]
        self.qgsElement += posString + '</qgsAnchPos>'
      elif self.name == 'osgb:font':
        fontNumber = int(ch)
        fontString = ''
        try:
          fontString = self.fonts[fontNumber]
        except:
          fontString = 'unknown font (' + str(fontNumber) + ')'
        self.qgsElement += fontString + '</qgsFont>'
        
      if self.outputToShape and ( self.name == 'osgb:theme' or self.name == 'osgb:descriptiveGroup' or self.name == 'osgb:descriptiveTerm' ):
        self.topoTerms += ch
      
      self.output(saxutils.escape(ch))

  def endElement(self, name):
    
    self.output('</' + name + '>')
    if len(self.qgsElement) > 0:
      self.output(self.qgsElement)
      self.qgsElement = ''
      
    self.lastName = self.name

  def output(self, str):
    sys.stdout.write(str.encode('utf-8'))

def main():
  if len(sys.argv) < 2:
    print 'usage: python preposmm4ogr.py gmlfile'
    sys.exit(1)
    
  outputToShape = False
  if len(sys.argv) == 3:
    for arg in sys.argv:
      if arg == '--output-to-shape':
        outputToShape = True
  
  inputfile = sys.argv[-1]
  if os.path.exists(inputfile):
    parser = make_parser()
    parser.setContentHandler(osmmHandler(outputToShape))
    if os.path.splitext(inputfile)[1].lower() == '.gz':
        file = gzip.open(inputfile, 'r')
    else:
		# Assume non compressed gml, xml or no extension
        file = open(inputfile, 'r')
    parser.parse(file)
  else:
    print 'Could not find input file: ' + inputfile
    sys.exit(1)
  sys.exit(0)

if __name__ == '__main__':
  main()
