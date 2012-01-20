import os
from lxml import etree

class prep_osmm():

    def __init__ (self, inputfile):
        self.inputfile = inputfile
        self.feat_types = [
            'BoundaryLine',
            'CartographicSymbol',
            'CartographicText',
            'TopographicArea',
            'TopographicLine',
            'TopographicPoint'
        ]
        self.list_seperator = ', '

    def get_feat_types(self):
        return self.feat_types

    def prepare_feature(self, feat_str):

        # Parse the xml string into something useful
        feat_elm = etree.fromstring(feat_str)
        feat_elm = self._prepare_feat_elm(feat_elm)

        return etree.tostring(feat_elm, encoding="UTF-8", pretty_print=False).decode('utf_8');

    def _prepare_feat_elm(self, feat_elm):

        feat_elm = self._add_fid_elm(feat_elm)
        feat_elm = self._add_filename_elm(feat_elm)
        feat_elm = self._add_orientation_degree_elms(feat_elm)
        feat_elm = self._add_lists_elms(feat_elm)
        
        return feat_elm

    def _add_fid_elm(self, feat_elm):

        # Create an element with the fid
        elm = etree.SubElement(feat_elm, "fid")
        elm.text = feat_elm.get('fid')

        return feat_elm
        
    def _add_filename_elm(self, feat_elm):

        # Create an element with the fid
        elm = etree.SubElement(feat_elm, "filename")
        elm.text = self.inputfile

        return feat_elm

    def _add_orientation_degree_elms(self, feat_elm):

        # Correct any orientation values to be a
        # tenth of their original value
        orientation_elms = feat_elm.xpath('//orientation')
        for elm in orientation_elms:
            # Add a new orientDeg element as a child to the
            # the orientation elm to be orientation/10
            # (this applies integer division which is fine in
            # this instance as we are not concerned with the decimals)
            degree_elm = etree.SubElement(elm.getparent(), "orientDeg")
            degree_elm.text = str(int(elm.text)/10)

        return feat_elm

    def _add_lists_elms(self, feat_elm):

        feat_elm = self._create_list_of_terms(feat_elm, 'theme')
        feat_elm = self._create_list_of_terms(feat_elm, 'descriptiveGroup')
        feat_elm = self._create_list_of_terms(feat_elm, 'descriptiveTerm')

        return feat_elm
        
    def _create_list_of_terms(self, feat_elm, name):
        text_list = feat_elm.xpath('//%s/text()' % name)
        if len(text_list):
            elm = etree.SubElement(feat_elm, "%ss" % name)
            elm.text = self.list_seperator.join(text_list)
        return feat_elm

class prep_osmm_qgis(prep_osmm):

    def __init__ (self):
        prep_osmm.__init__(self)

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
        self.anchorPosition = ('Bottom Left','Left','Top Left','Bottom','Over',
                               'Top', 'Bottom Right','Right','Top Right')

    def _prepare_feat_elm(self, feat_elm):

        feat_elm = prep_osmm._prepare_feat_elm(self, feat_elm)
        feat_elm = self._add_qgis_elms(feat_elm)

        return feat_elm

    def _add_qgis_elms(self, feat_elm):
        
        if feat_elm.tag == 'CartographicText':
            text_render_elm = feat_elm.xpath('//textRendering')[0]

            anchor_pos = int(text_render_elm.xpath('./anchorPosition/text()')[0])
            try:
                anchor_pos = self.anchorPosition[anchor_pos]
            except:
                anchor_pos = 4
            elm = etree.SubElement(text_render_elm, 'qAnchorPos')
            elm.text = anchor_pos

            font = int(text_render_elm.xpath('./font/text()')[0])
            try:
                font = self.fonts[font]
            except:
                font = 'unknown font (%s)' % str(font)
            elm = etree.SubElement(text_render_elm, 'qFont')
            elm.text = font

        return feat_elm

