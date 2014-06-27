#!/usr/bin/python

''' SAX parser implementation to prepare an Ordnance Survey
    GML file (.gml or .gz) so that it is ready to be loaded by OGR 1.9
    or above.
    The parser promotes the fid attribute to a child element.
    Output is via stdout and is UTF-8 encoded.

    usage: python prepgml4ogr.py file.gml
'''

import sys
import os.path
import gzip
import zipfile
from xml.sax import make_parser
from xml.sax.handler import ContentHandler
from xml.sax import saxutils


class gmlhandler(ContentHandler):

    def __init__(self, preparer):
        # The class that will prepare the features
        self.preparer = preparer
        # Flag to indicate if we have encountered the first element yet
        self.first_elm = True
        self.feat = None
        self.recording = False

    def startElement(self, name, attrs):
        if self.first_elm:
            # Output the xml declaration prior to the first element,
            # done here instead of in startDocument to allow us to avoid
            # outputting the declaration when we try and parse non XML content
            # as can happen when we parse all files in a zip archive
            self.first_elm = False
            output('<?xml version="1.0" ?>')
        try:
            name = name.split(':')[1]
        except IndexError:
            pass
        # Determine if we are interested
        # in starting to record the raw
        # XML string so we can prepare
        # the feature when the feature ends
        if name in self.preparer.feat_types:
            self.buffer = []
            self.recording = True
        # Process the attributes
        tmp = '<' + name
        for (name, value) in attrs.items():
            try:
                name = name.split(':')[1]
            except IndexError:
                pass
            tmp += ' %s=%s' % (name, saxutils.quoteattr(value))
        tmp += '>'
        if self.recording:
            self.buffer.append(tmp)
        else:
            output(tmp)
        return

    def characters(self, ch):
        if len(ch.strip()) > 0:
            if self.recording:
                self.buffer.append(saxutils.escape(ch))
            else:
                output(saxutils.escape(ch))

    def endElement(self, name):
        try:
            name = name.split(':')[1]
        except IndexError:
            pass
        if self.recording:
            self.buffer.append('</' + name + '>')
        else:
            output('</' + name + '>')
        if name in self.preparer.feat_types:
            self.recording = False
            output(self.preparer.prepare_feature(''.join(self.buffer)))
            self.buffer = []


def output(str):
    try:
        sys.stdout.write(str.encode('utf_8', 'xmlcharrefreplace').decode('utf_8'))
    except UnicodeEncodeError:
        sys.stdout.write(str.encode('utf_8', 'xmlcharrefreplace'))


class prep_gml():

    def __init__(self, inputfile):
        self.feat_types = []

    def get_feat_types(self):
        return self.feat_types

    def prepare_feature(self, feat_str):
        return feat_str


def main():
    if len(sys.argv) < 2:
        print('usage: python prepgml4ogr.py file [[prep_module.]prep_class]')
        sys.exit(1)

    inputfile = sys.argv[1]
    if os.path.exists(inputfile):

        # Create an instance of a preparer
        # class which is used to prepare
        # features as they are read
        prep_class = 'prep_gml'
        try:
            prep_class = sys.argv[2]
        except IndexError:
            pass
        prep_class = get_preparer(prep_class)
        preparer = prep_class(inputfile)

        parser = make_parser()
        parser.setContentHandler(gmlhandler(preparer))

        if os.path.splitext(inputfile)[1].lower() == '.zip':
            archive = zipfile.ZipFile(inputfile, 'r')
            for filename in archive.namelist():
                file = archive.open(filename)
                try:
                    parser.parse(file)
                except:
                    # Ignore any files that can't be parsed
                    pass
        else:
            if os.path.splitext(inputfile)[1].lower() == '.gz':
                file = gzip.open(inputfile, 'r')
            else:
                # Assume non compressed gml, xml or no extension
                file = open(inputfile, 'r')
            parser.parse(file)

    else:
        print('Could not find input file: ' + inputfile)


def get_preparer(prep_class):
    parts = prep_class.split('.')
    if len(parts) > 1:
        prep_module = parts[0]
        prep_module = __import__(prep_module)
        prep_class = getattr(prep_module, parts[1])
    else:
        prep_class = globals()[prep_class]
    return prep_class

if __name__ == '__main__':
    main()
