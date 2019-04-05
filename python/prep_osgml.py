# Loader. Copyright (c) Astun Technology Ltd. (http://astuntechnology.com).
# Licensed under [MIT License](https://git.io/fAxH0).

"""
A collection of classes used to manipulate Ordnance Survey GB GML data,
used with prepgml4ogr.py.
"""
from lxml import etree
from lxml import objectify
import json
import lxml
import os
import re

import sys
# Mock arcpy which is imported by not used in the ESRI UK modules used to
# classify OSMM Topo features
sys.modules['arcpy'] = __import__('sys')
import osmm_topo_style.area_style
import osmm_topo_style.bnd_style
import osmm_topo_style.line_style
import osmm_topo_style.pnt_style
import osmm_topo_style.sym_style
import osmm_topo_style.txt_style


class prep_osgml():
    """
    Base class that provides the main interface methods `prepare_feature` and
    `get_feat_types` and performs basic manipulation such as exposing the fid,
    adding and element containing the filename of the source and adding an
    element with the orientation in degrees.

    """
    def __init__(self, inputfile):
        self.inputfile = inputfile
        self.feat_types = []

    def get_feat_types(self):
        return self.feat_types

    def prepare_feature(self, feat_str):

        # Parse the xml string into something useful
        feat_elm = etree.fromstring(feat_str)
        feat_elm = self._prepare_feat_elm(feat_elm)

        return etree.tostring(feat_elm,
                              encoding='UTF-8',
                              pretty_print=True).decode('utf_8')

    def _prepare_feat_elm(self, feat_elm):

        feat_elm = self._set_srs(feat_elm)
        feat_elm = self._add_fid_elm(feat_elm)
        feat_elm = self._add_filename_elm(feat_elm)
        feat_elm = self._add_orientation_degree_elms(feat_elm)

        return feat_elm

    def _set_srs(self, feat_elm):

        srs_elms = feat_elm.xpath('//*[@srsName]')
        for elm in srs_elms:
            elm.attrib['srsName'] = 'EPSG:27700'

        return feat_elm

    def _add_fid_elm(self, feat_elm):

        # Create an element with the fid
        elm = etree.SubElement(feat_elm, "fid")
        elm.text = feat_elm.get('fid')

        return feat_elm

    def _add_filename_elm(self, feat_elm):

        # Create an element with the filename
        elm = etree.SubElement(feat_elm, "filename")
        elm.text = os.path.basename(self.inputfile)

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
            degree_elm.text = str(int(elm.text) / 10)

        return feat_elm


class prep_vml(prep_osgml):
    """
    Preparation class for OS VectorMap Local features.

    """
    def __init__(self, inputfile):
        prep_osgml.__init__(self, inputfile)
        self.feat_types = [
            'Text',
            'VectorMapPoint',
            'Line',
            'RoadCLine',
            'Area',
            'RailCLine',
            'creationDate'
        ]

    def _prepare_feat_elm(self, feat_elm):

        # We need to record the creation date so that we can include it as an
        # attribute on all features, when we are passed the creationDate
        # element simply record it's text value and return it as is. This is
        # potentially brittle as it assumes that the creationDate element
        # appears before the features in the source GML.
        if feat_elm.tag == 'creationDate':
            self.creation_date = feat_elm.text
            return feat_elm
        else:
            feat_elm = prep_osgml._prepare_feat_elm(self, feat_elm)
            #feat_elm = self._add_tile_elm(feat_elm)
            #feat_elm = self._add_creation_date_elm(feat_elm)
            return feat_elm

    def _add_tile_elm(self, feat_elm):

        elm = etree.SubElement(feat_elm, "tile")
        elm.text = os.path.splitext(os.path.basename(self.inputfile))[0]

        return feat_elm

    def _add_creation_date_elm(self, feat_elm):

        elm = etree.SubElement(feat_elm, "creationDate")
        elm.text = self.creation_date

        return feat_elm


class prep_vmd(prep_osgml):

    def __init__(self, inputfile):
        prep_osgml.__init__(self, inputfile)
        self.feat_types = [
            'AdministrativeBoundary',
            'Building',
            'ElectricityTransmissionLine',
            'Foreshore',
            'FunctionalSite',
            'Glasshouse',
            'NamedPlace',
            'Woodland',
            'Ornament',
            'RailwayStation',
            'RailwayTrack',
            'RailwayTunnel',
            'Road',
            'MotorwayJunction',
            'RoadTunnel',
            'Roundabout',
            'SpotHeight',
            'SurfaceWater_Area',
            'SurfaceWater_Line',
            'TidalBoundary',
            'TidalWater'
        ]

    def _add_fid_elm(self, feat_elm):

        # Create an element with the fid
        elm = etree.SubElement(feat_elm, "fid")
        elm.text = feat_elm.get('id')

        return feat_elm


class prep_osmm_topo(prep_osgml):
    """
    Preparation class for OS MasterMap features which in addition to the work
    performed by `prep_osgml` adds `themes`, `descriptiveGroups` and
    `descriptiveTerms` elements containing a delimited string of the attributes
    that can appear multiple times.

    """
    def __init__(self, inputfile):
        prep_osgml.__init__(self, inputfile)
        self.feat_types = [
            'BoundaryLine',
            'CartographicSymbol',
            'CartographicText',
            'TopographicArea',
            'TopographicLine',
            'TopographicPoint'
        ]
        self.list_seperator = ', '

    def _prepare_feat_elm(self, feat_elm):

        feat_elm = prep_osgml._prepare_feat_elm(self, feat_elm)
        feat_elm = self._add_lists_elms(feat_elm)
        feat_elm = self._add_style_elms(feat_elm)

        return feat_elm

    def _add_lists_elms(self, feat_elm):

        feat_elm = self._create_list_of_terms(feat_elm, 'theme')
        feat_elm = self._create_list_of_terms(feat_elm, 'descriptiveGroup')
        feat_elm = self._create_list_of_terms(feat_elm, 'descriptiveTerm')

        return feat_elm

    def _add_style_elms(self, feat_elm):

        descriptiveTerms = self._get_list_of_terms(feat_elm, 'descriptiveTerms')
        descriptiveGroups = self._get_list_of_terms(feat_elm, 'descriptiveGroups')
        make = self._get_list_of_terms(feat_elm, 'make')
        physicalPresence = self._get_list_of_terms(feat_elm, 'physicalPresence')
        featureCode = int(self._get_list_of_terms(feat_elm, 'featureCode'))

        style_code = 99
        style_description = 'Unclassified'
        if feat_elm.tag == 'TopographicArea':
            row = ['', '', '', descriptiveTerms, descriptiveGroups, make]
            style_code = osmm_topo_style.area_style.CalculateStyleCode(row)
            style_description = osmm_topo_style.area_style.CalculateStyleDescription(row)
        elif feat_elm.tag == 'TopographicLine':
            row = ['', '', '', descriptiveTerms, descriptiveGroups, make, physicalPresence]
            style_code = osmm_topo_style.line_style.CalculateStyleCode(row)
            style_description = osmm_topo_style.line_style.CalculateStyleDescription(row)
        elif feat_elm.tag == 'TopographicPoint':
            row = ['', '', '', descriptiveGroups, descriptiveTerms, make]
            style_code = osmm_topo_style.pnt_style.CalculateStyleCode(row)
            style_description = osmm_topo_style.pnt_style.CalculateStyleDescription(row)
        elif feat_elm.tag == 'BoundaryLine':
            row = ['', '', '', featureCode]
            style_code = osmm_topo_style.bnd_style.CalculateStyleCode(row)
            style_description = osmm_topo_style.bnd_style.CalculateStyleDescription(row)
        elif feat_elm.tag == 'CartographicSymbol':
            row = ['', '', '', featureCode]
            style_code = osmm_topo_style.sym_style.CalculateStyleCode(row)
            style_description = osmm_topo_style.sym_style.CalculateStyleDescription(row)
        elif feat_elm.tag == 'CartographicText':
            anchorPosition = float(self._get_list_of_terms(feat_elm, 'anchorPosition'))
            orientation = float(self._get_list_of_terms(feat_elm, 'orientation'))
            row = ['', '', '', descriptiveGroups, descriptiveTerms, make, anchorPosition, '', '', '', '', '', '', orientation]
            style_code = osmm_topo_style.txt_style.CalculateStyleCode(row)
            style_description = osmm_topo_style.txt_style.CalculateStyleDescription(row)

            anchor = osmm_topo_style.txt_style.CalculateAnchor(row)
            elm = etree.SubElement(feat_elm, 'anchor')
            elm.text = unicode(anchor)
            geo_x = osmm_topo_style.txt_style.CalculateGeoX(row)
            elm = etree.SubElement(feat_elm, 'geo_x')
            elm.text = unicode(geo_x)
            geo_y = osmm_topo_style.txt_style.CalculateGeoY(row)
            elm = etree.SubElement(feat_elm, 'geo_y')
            elm.text = unicode(geo_y)
            font_code = osmm_topo_style.txt_style.CalculateFontCode(row)
            elm = etree.SubElement(feat_elm, 'font_code')
            elm.text = unicode(font_code)
            colour_code = osmm_topo_style.txt_style.CalculateColorCode(row)
            elm = etree.SubElement(feat_elm, 'colour_code')
            elm.text = unicode(colour_code)
            rotation = osmm_topo_style.txt_style.CalculateRotation(row)
            elm = etree.SubElement(feat_elm, 'rotation')
            elm.text = unicode(rotation)

        elm = etree.SubElement(feat_elm, "%s" % 'styleCode')
        elm.text = unicode(style_code)

        elm = etree.SubElement(feat_elm, "%s" % 'styleDescription')
        elm.text = unicode(style_description)

        return feat_elm

    def _create_list_of_terms(self, feat_elm, name):
        text_list = feat_elm.xpath('//%s/text()' % name)
        if len(text_list):
            elm = etree.SubElement(feat_elm, "%ss" % name)
            elm.text = self.list_seperator.join(text_list)
        return feat_elm

    def _get_list_of_terms(self, feat_elm, name):
        text_list = feat_elm.xpath('//%s/text()' % name)
        if len(text_list):
            return self.list_seperator.join(text_list)
        return ''


class prep_osmm_topo_qgis(prep_osmm_topo):
    """
    Preparation class for OS MasterMap features which in addition to the work performed by
    `prep_osmm_topo` adds QGIS specific label attributes such as `qFont` and `aAnchorPos`.

    """

    def __init__(self, filename):
        prep_osmm_topo.__init__(self, filename)

        # AC - define the font
        if os.name is 'posix':
            # Will probably need different font names
            self.fonts = ('Garamond', 'Arial', 'Roman', 'ScriptC')
        elif os.name is 'nt':
            # Ordnance Survey use
            #   'Lutheran', 'Normal', 'Light Roman', 'Suppressed text'
            self.fonts = ('GothicE', 'Monospac821 BT', 'Consolas', 'ScriptC', 'Arial Narrow')
        elif os.name is 'mac':
            # Will probably need different font name
            self.fonts = ('Garamond', 'Arial', 'Roman', 'ScriptC')

        # AC - the possible text placement positions used by QGIS
        self.anchorPosition = ('Bottom Left', 'Left', 'Top Left', 'Bottom',
                               'Over', 'Top', 'Bottom Right', 'Right', 'Top Right')

    def _prepare_feat_elm(self, feat_elm):

        feat_elm = prep_osmm_topo._prepare_feat_elm(self, feat_elm)
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


class prep_osmm_itn(prep_osgml):
    """
    Preparation class for OS MasterMap ITN features.

    """

    def __init__(self, filename):

        prep_osgml.__init__(self, filename)

        self.feat_types = [
            'Road',
            'RoadLink',
            'RoadNode',
            'FerryLink',
            'FerryNode',
            'FerryTerminal',
            'InformationPoint',
            'RoadNodeInformation',
            'RoadLinkInformation',
            'RoadRouteInformation'
        ]

    def _prepare_feat_elm(self, feat_elm):

        feat_elm = prep_osgml._prepare_feat_elm(self, feat_elm)
        feat_elm = self._expose_attributes(feat_elm)
        feat_elm = self._add_datetime_summary(feat_elm)
        feat_elm = self._add_datetime_json(feat_elm)

        return feat_elm

    def _expose_attributes(self, feat_elm):

        elm_list = feat_elm.xpath("""//networkMember |
                                    //directedLink |
                                    //directedNode |
                                    //referenceToRoadLink |
                                    //referenceToRoadNode |
                                    //referenceToTopographicArea |
                                    //referenceToNetwork |
                                    //vehicleQualifier/type |
                                    //vehicleQualifier/use""")

        # Default attribute values for optional attributes
        defaults = {
            'directedNode': {'gradeSeparation': '0'},
            'referenceToRoadNode': {'gradeSeparation': '0'}
        }

        for elm in elm_list:

            # Assign default values to optional attributes
            if elm.tag in defaults.keys():
                for key, val in defaults[elm.tag].items():
                    if key not in elm.attrib:
                        elm.attrib[key] = val

            for name in elm.attrib:
                value = elm.get(name)
                name = '%s_%s' % (elm.tag, name)
                sub_elm = etree.SubElement(elm if not elm.text else elm.getparent(), name)
                sub_elm.text = value

        return feat_elm

    def _add_datetime_summary(self, feat_elm):

        def elm_str(elm):
            return elm.tag + ((': ' + elm.text) if elm.text else '')

        for elm in feat_elm.xpath('//dateTimeQualifier'):
            # Create a basic summary by listing tag names and values
            value = ', '.join(map(elm_str, elm.xpath(".//*")))
            sub_elm = etree.SubElement(feat_elm, 'dateTimeQualifier_summary')
            sub_elm.text = value

        return feat_elm

    def _add_datetime_json(self, feat_elm):
        """ Add a JSON representation of dateTimeQualifier elements """

        elms = feat_elm.xpath('//dateTimeQualifier')
        if elms:
            objs = [objectify.fromstring(etree.tostring(elm)) for elm in elms]
            sub_elm = etree.SubElement(feat_elm, 'dateTimeQualifier_json')
            sub_elm.text = ObjectifyJSONEncoder().encode(objs)

        return feat_elm


class prep_osmm_highways(prep_osgml):
    """
    Preparation class for OS MasterMap Highways features.

    """

    def __init__(self, filename):

        prep_osgml.__init__(self, filename)

        self.feat_types = [
            'AccessRestriction',
            'HighwayDedication',
            'FerryLink',
            'FerryNode',
            'FerryTerminal',
            'Hazard',
            'Maintenance',
            'Reinstatement',
            'RestrictionForVehicles',
            'Road',
            'RoadJunction',
            'RoadLink',
            'RoadNode',
            'SpecialDesignation',
            'Street',
            'Structure',
            'TurnRestriction'
        ]

    def _prepare_feat_elm(self, feat_elm):

        # Expose the gml:id as fid which OGR will detect
        feat_elm.attrib['fid'] = feat_elm.attrib['id']

        feat_elm = self._add_time_interval_json(feat_elm)
        feat_elm = self._remove_id_hash(feat_elm)

        return feat_elm

    def _remove_id_hash(self, feat_elm):

        for attr in feat_elm.xpath('//@href'):
            if attr.startswith('#'):
                elm = attr.getparent()
                elm.attrib['href'] = attr[1:]

        return feat_elm

    def _add_time_interval_json(self, feat_elm):
        """ Add a JSON representation of timeInterval elements """

        elms = feat_elm.xpath('//timeInterval')
        if elms:
            objs = [objectify.fromstring(etree.tostring(elm)) for elm in elms]
            sub_elm = etree.SubElement(feat_elm, 'timeInterval_json')
            sub_elm.text = ObjectifyJSONEncoder().encode(objs)

        return feat_elm


class prep_addressbase():
    """
    Simple preparation of AddressBase data

    """
    def __init__(self, inputfile):
        self.inputfile = inputfile
        self.feat_types = ['Address']

    def get_feat_types(self):
        return self.feat_types

    def prepare_feature(self, feat_str):

        # Parse the xml string into something useful
        feat_elm = etree.fromstring(feat_str)
        feat_elm = self._prepare_feat_elm(feat_elm)

        return etree.tostring(feat_elm,
                              encoding='UTF-8',
                              pretty_print=True).decode('utf_8')

    def _prepare_feat_elm(self, feat_elm):

        feat_elm = self._drop_gmlid(feat_elm)

        return feat_elm

    def _drop_gmlid(self, feat_elm):

        feat_elm.attrib.pop('id')

        return feat_elm


class prep_addressbase_premium(prep_addressbase):
    """
    Preparation of AddressBase Premium data

    """
    def __init__(self, inputfile):
        prep_addressbase.__init__(self, inputfile)
        self.feat_types = ['BasicLandPropertyUnit', 'Street']

    def prepare_feature(self, feat_str):

        # Parse the xml string into something useful
        feat_elm = etree.fromstring(feat_str)

        # Manipulate the feature
        feat_elm = self._prepare_feat_elm(feat_elm)

        # In this instance we are not returning a string representing a single
        # element as we are unnesting features in the AddressBase Premium GML.
        # We end up returning a string of several elements which are wrapped in
        # the output document with either a streetMember or
        # basicLandPropertyUnitMember element which result it valid XML
        elms = [etree.tostring(feat_elm,
                               encoding='UTF-8',
                               pretty_print=True).decode('utf_8')]

        for elm in self.member_elms:
            elms.append(
                etree.tostring(elm, encoding='UTF-8',
                               pretty_print=True).decode('utf_8'))

        return ''.join(elms)

    def _prepare_feat_elm(self, feat_elm):

        feat_elm = prep_addressbase._prepare_feat_elm(self, feat_elm)
        feat_elm = self._to_multipoint(feat_elm)
        self.member_elms = self._extract_child_members(feat_elm)

        return feat_elm

    def _to_multipoint(self, feat_elm):
        """ Move Street streetStart and streetEnd Point elements into a
        MultiPoint """

        if feat_elm.tag == 'Street':

            multi_elm = etree.SubElement(etree.SubElement(feat_elm, 'geom'),
                                         'MultiPoint')
            point_elms = feat_elm.xpath('//streetStart/Point|//streetEnd/Point')
            for point_elm in point_elms:
                etree.SubElement(multi_elm, 'pointMember').append(point_elm)

        return feat_elm

    def _extract_child_members(self, feat_elm):
        """ Unnest BLPU and Street feature types adding a reference to uprn or
        usrn as appropriate """

        if feat_elm.tag == 'BasicLandPropertyUnit':
            uprn = feat_elm.findtext('uprn')
            child_elms = feat_elm.xpath("""//Classification |
                                           //LandPropertyIdentifier |
                                           //ApplicationCrossReference |
                                           //DeliveryPointAddress |
                                           //Organisation""")
            for elm in child_elms:
                elm.getparent().remove(elm)
                elm = self._add_lang_elm(elm)
                sub_elm = etree.SubElement(elm, 'uprn')
                sub_elm.text = uprn

        if feat_elm.tag == 'Street':
            usrn = feat_elm.findtext('usrn')
            child_elms = feat_elm.xpath("//StreetDescriptiveIdentifier")
            for elm in child_elms:
                elm.getparent().remove(elm)
                elm = self._add_lang_elm(elm)
                sub_elm = etree.SubElement(elm, 'usrn')
                sub_elm.text = usrn

        return child_elms

    def _add_lang_elm(self, feat_elm):

        if feat_elm.tag in ['StreetDescriptiveIdentifier', 'LandPropertyIdentifier']:
            elm = etree.SubElement(feat_elm, "lang")
            try:
                lang = feat_elm.xpath('.//@lang')[0]
            except IndexError:
                lang = 'en'
            elm.text = lang

        return feat_elm


class prep_osmm_water():
    """
    Preparation of OSMM Water Layer features

    """
    def __init__(self, inputfile):
        self.inputfile = inputfile
        self.feat_types = ['WatercourseLink', 'HydroNode']

    def prepare_feature(self, feat_str):

        # Parse the xml string into something useful
        feat_elm = etree.fromstring(feat_str)
        feat_elm = self._prepare_feat_elm(feat_elm)

        return etree.tostring(feat_elm,
                              encoding='UTF-8',
                              pretty_print=True).decode('utf_8')

    def _prepare_feat_elm(self, feat_elm):

        feat_elm = self._add_fid_elm(feat_elm)
        feat_elm = self._add_filename_elm(feat_elm)
        feat_elm = self._add_start_end_node_elm(feat_elm)
        feat_elm = self._add_code_list_values(feat_elm)

        return feat_elm

    def _add_fid_elm(self, feat_elm):

        # Create an element with the fid
        elm = etree.SubElement(feat_elm, "fid")
        elm.text = feat_elm.get('id')

        return feat_elm

    def _add_filename_elm(self, feat_elm):

        # Create an element with the filename
        elm = etree.SubElement(feat_elm, "filename")
        elm.text = os.path.basename(self.inputfile)

        return feat_elm

    def _add_start_end_node_elm(self, feat_elm):

        start_elm = feat_elm.xpath('//startNode')
        if len(start_elm):
            etree.SubElement(feat_elm,
                             'startNode').text = start_elm[0].get('href')[1:]
        end_elm = feat_elm.xpath('//endNode')
        if len(end_elm):
            etree.SubElement(feat_elm,
                             'endNode').text = end_elm[0].get('href')[1:]

        return feat_elm

    def _add_code_list_values(self, feat_elm):

        list_elms = feat_elm.xpath("""//reasonForChange |
                                        //form |
                                        //provenance |
                                        //levelOfDetail""")

        r = re.compile('#(.*)$')
        for elm in list_elms:
            matches = r.findall(elm.get('href'))
            if len(matches):
                elm.text = matches[0]

        return feat_elm


class prep_emapsite_addressbase_premium(prep_osgml):
    """
    Prepare emapsite OS AddressBase Premium GML output by FME
    """
    def __init__(self, inputfile):
        prep_osgml.__init__(self, inputfile)
        # Looking at the sample data it doesn't appear as though the name of
        # the AddressBaseT_Plus feature type is likely to be the same for each
        # supply so as there is only one feature type simply specify the
        # containing featureMember
        self.feat_types = ['featureMember']

    def _prepare_feat_elm(self, feat_elm):

        feat_elm = self._add_geom(feat_elm)

        return feat_elm

    def _add_geom(self, feat_elm):
        """ Add a GML Point element to a feature with coordinates taken from
            the x_coordinate and y_coordinate fields """

        pos_elm = etree.SubElement(feat_elm, 'Pos')
        pos_elm.text = '%s %s' % (feat_elm.findtext('.//x_coordinate'), feat_elm.findtext('.//y_coordinate'))

        pnt_elm = etree.SubElement(feat_elm, 'Point')
        pnt_elm.attrib['srsName'] = 'EPSG:27700'
        pnt_elm.append(pos_elm)

        # Append the Point element to the first child
        list(feat_elm)[0].append(pnt_elm)

        return feat_elm


class ObjectifyJSONEncoder(json.JSONEncoder):
    """ JSON encoder that can handle simple lxml objectify types,
        based on the original: https://gist.github.com/aisipos/345559, extended
        to accommodate encoding child nodes with the same tag name as a list.

        Usage:

        >>> import json
        >>> import lxml
        >>> from lxml import objectify
        >>> obj = objectify.fromstring("<author><name>W. Shakespeare</name><play>Twelfth Night</play><play>As You Like It</play></author>")
        >>> json.dumps(obj, cls=ObjectifyJSONEncoder)
        '{"play": ["Twelfth Night", "As You Like It"], "name": "W. Shakespeare"}'

    """
    def default(self, o):
        if isinstance(o, lxml.objectify.IntElement):
            return int(o)
        if isinstance(o, lxml.objectify.NumberElement) or isinstance(o, lxml.objectify.FloatElement):
            return float(o)
        if isinstance(o, lxml.objectify.ObjectifiedDataElement):
            return str(o)
        if hasattr(o, '__dict__'):
            # objectify elements act like dicts to allow access to child nodes
            # via their tag name.  If an element has more than one child of the
            # same name the dict only contains the first value against the tag
            # name; to ensure all children are encoded create a list of child
            # node values and assign it to the key that matches their tag name.
            d = o.__dict__.copy()
            for k in d.keys():
                if len(d[k]) > 1:
                    d[k] = [i for i in d[k]]
            return d
        return json.JSONEncoder.default(self, o)
