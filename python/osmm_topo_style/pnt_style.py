#-------------------------------------------------------------------------------
# Name:        Point Style
# Purpose:
#
# Author:      sbatterby
#
# Created:     09/02/2016
# Copyright:   (c) sbatterby 2016
# Licence:     <your licence>
#-------------------------------------------------------------------------------

import arcpy
import os
import logging

logger = logging.getLogger("style_debug")



#-------------------------------------------------------------------------------
# Calculates the style code value
def CalculateStyleCode(row):
    descGroup = row[3]
    descTerm = row[4]
    returnVal = 99

    if descTerm is None:
        descTerm = ""

    if descGroup is None:
        descGroup = ""

    if (descTerm == "Spot Height"):
        returnVal = 1
    elif (descTerm == "Emergency Telephone"):
        returnVal = 2
    elif (descTerm.find("Site Of Heritage") > -1):
        returnVal = 3
    elif (descTerm.find("Culvert") > -1):
        returnVal = 4
    elif (descTerm == "Positioned Nonconiferous Tree"):
        returnVal = 5
    elif (descGroup.find("Inland Water") > -1):
        returnVal = 6
    elif (descGroup.find("Roadside") > -1):
        returnVal = 7
    elif (descTerm.find("Overhead Construction") > -1):
        returnVal = 8
    elif (descGroup.find("Rail") > -1):
        returnVal = 9
    elif (descTerm == "Positioned Coniferous Tree"):
        returnVal = 10
    elif (descTerm == "Boundary Post Or Stone"):
        returnVal = 11
    elif (descTerm == "Triangulation Point Or Pillar"):
        returnVal = 12
    elif (descGroup == "Historic Interest"):
        returnVal = 13
    elif (descGroup == "Landform" or descTerm == "Positioned Boulder"):
        returnVal = 14
    elif (descGroup.find("Tidal Water") > -1):
        returnVal = 15
    elif (descGroup.find("Structure") > -1):
        returnVal = 16
    else:
        returnVal = 99

    logger.debug("Style Code:"+ str(returnVal))

    return returnVal
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# Calculates the style description value
def CalculateStyleDescription(row):
    descGroup = row[3]
    descTerm = row[4]
    returnVal = "Unclassified"

    if descTerm is None:
        descTerm = ""

    if descGroup is None:
        descGroup = ""

    if (descTerm == "Spot Height"):
        returnVal = "Spot Height Point"
    elif (descTerm == "Emergency Telephone"):
        returnVal = "Emergency Telephone Point"
    elif (descTerm.find("Site Of Heritage") > -1):
        returnVal = "Site Of Heritage Point"
    elif (descTerm.find("Culvert") > -1):
        returnVal = "Culvert Point"
    elif (descTerm == "Positioned Nonconiferous Tree"):
        returnVal = "Positioned Nonconiferous Tree Point"
    elif (descGroup.find("Inland Water") > -1):
        returnVal = "Inland Water Point"
    elif (descGroup.find("Roadside") > -1):
        returnVal = "Roadside Point"
    elif (descTerm.find("Overhead Construction") > -1):
        returnVal = "Overhead Construction Point"
    elif (descGroup.find("Rail") > -1):
        returnVal = "Rail Point"
    elif (descTerm == "Positioned Coniferous Tree"):
        returnVal = "Positioned Coniferous Tree Point"
    elif (descTerm == "Boundary Post Or Stone"):
        returnVal = "Boundary Post Point"
    elif (descTerm == "Triangulation Point Or Pillar"):
        returnVal = "Triangulation Point Or Pillar Point"
    elif (descGroup == "Historic Interest"):
        returnVal = "Historic Point"
    elif (descGroup == "Landform" or descTerm == "Positioned Boulder"):
        returnVal = "Landform Point"
    elif (descGroup.find("Tidal Water") > -1):
        returnVal = "Tidal Water Point"
    elif (descGroup.find("Structure") > -1):
        returnVal = "Structure Point"
    else:
        returnVal = "Unclassified"


    logger.debug("Style Description:"+ returnVal)

    return returnVal;
#-------------------------------------------------------------------------------




