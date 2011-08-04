from lxml import etree

class prep_osmm():

    def __init__ (self):
        self.feat_types = [
            'BoundaryLine',
            'CartographicSymbol',
            'CartographicText',
            'TopographicArea',
            'TopographicLine',
            'TopographicPoint'
        ]

    def get_feat_types(self):
        return self.feat_types

    def prepare_feature(self, feat_str):

        # Parse the xml string into something useful
        feat_elm = etree.fromstring(feat_str)

        # Create an element with the fid
        elm = etree.SubElement(feat_elm, "fid")
        elm.text = feat_elm.get('fid')

        # Correct any orientation values to be a
        # tenth of their original value
        orientation_elms = feat_elm.xpath('//orientation')
        for elm in orientation_elms:
            # Update the orientation to be orientation/10
            # (this applies integer division which is fine in
            # this instance as we are not concerned with the decimals)
            elm.text = str(int(elm.text)/10)
            
        return etree.tostring(feat_elm, encoding="UTF-8")
