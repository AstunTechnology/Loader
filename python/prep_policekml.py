"""
prep_kml class used to manipulate police.uk KML data, used with prepgml4ogr.py
"""
import os
from lxml import etree


class prep_kml():

    def __init__(self, inputfile):
        self.inputfile = inputfile
        self.infile = os.path.basename(inputfile)
        self.feat_types = ['Placemark']

    def get_feat_types(self):
        return self.feat_types

    def prepare_feature(self, feat_str):

        # Parse the xml string into something useful
        feat_elm = etree.fromstring(feat_str)
        feat_elm = self._prepare_feat_elm(feat_elm)

        return etree.tostring(feat_elm, encoding='UTF-8', pretty_print=True).decode('utf_8');

    def _prepare_feat_elm(self, feat_elm):

        feat_elm = self._add_filename_elm(feat_elm)

        return feat_elm

    def _add_filename_elm(self, feat_elm):

        elm = etree.SubElement(feat_elm, "name")
        elm.text = self.infile[:-4]

        elm = etree.SubElement(feat_elm, "description")
        elm.text = os.path.dirname(self.inputfile).split('/')[-1]

        return feat_elm
