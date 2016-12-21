#-------------------------------------------------------------------------------
# Name:        Cartographic Text Style
# Purpose:
#
# Author:      sbatterby
#
# Created:     09/02/2016
# Copyright:   (c) sbatterby 2016
#-------------------------------------------------------------------------------


import arcpy
import os
import logging

logger = logging.getLogger("style_debug")

# Calculates the orientation of the text
def CalculateRotation(row):
    orientation = row[13]

    if (orientation == 0):
        return 0
    else:
        return orientation / 10

#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Calculates the anchore value
def CalculateAnchor(row):
    textPos = row[6]
    returnVal = ""

    if (textPos == 0):
        returnVal = "SW"
    elif (textPos == 1):
        returnVal = "W"
    elif (textPos == 2):
        returnVal = "NW"
    elif (textPos == 3):
        returnVal = "S"
    elif (textPos == 4):
        returnVal = ""
    elif (textPos == 5):
        returnVal = "N"
    elif (textPos == 6):
        returnVal = "SE"
    elif (textPos == 7):
        returnVal = "E"
    elif (textPos == 8):
        returnVal = "NE"

    return returnVal
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Calculates the geo_y value
def CalculateGeoY(row):
    textPos = row[6]
    returnVal = 0

    if (textPos == 0):
        returnVal = 0
    elif (textPos == 1):
        returnVal = 0.5
    elif (textPos == 2):
        returnVal = 1
    elif (textPos == 3):
        returnVal = 0
    elif (textPos == 4):
        returnVal = 0.5
    elif (textPos == 5):
        returnVal = 1
    elif (textPos == 6):
        returnVal = 0
    elif (textPos == 7):
        returnVal = 0.5
    elif (textPos == 8):
        returnVal = 1

    return returnVal
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Calculates the geo_x value
def CalculateGeoX(row):
    textPos = row[6]
    returnVal = 0

    if (textPos == 0):
        returnVal = 0
    elif (textPos == 1):
        returnVal = 0
    elif (textPos == 2):
        returnVal = 0
    elif (textPos == 3):
        returnVal = 0.5
    elif (textPos == 4):
        returnVal = 0.5
    elif (textPos == 5):
        returnVal = 0.5
    elif (textPos == 6):
        returnVal = 1
    elif (textPos == 7):
        returnVal = 1
    elif (textPos == 8):
        returnVal = 1

    return returnVal
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Calculates the color code value
def CalculateFontCode(row):
    descGroup = row[3]
    descTerm = row[4]
    make = row[5]
    returnVal = 99
    
    if descTerm is None:
        descTerm = ""

    if descGroup is None:
        descGroup = ""

    if (descGroup is not None and (descGroup.find("Buildings Or Structure") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Inland Water") > -1)):
        returnVal = 2
    elif (descGroup is not None and (descGroup.find("Road Or Track") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Terrain And Height") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Roadside") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Structure") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Political Or Administrative") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("General Surface") > -1 and make == "Natural")):
        returnVal = 1
    elif ((descGroup is not None and (descGroup.find("General Surface") > -1 and make == "Manmade")) or (descGroup is not None and (descGroup.find("General Surface") > -1 and make is None))):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Landform") > -1) and make == "Natural"):
        returnVal = 1
    elif (descTerm is not None and (descTerm.find("Foreshore") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Tidal Water") > -1)):
        returnVal = 2
    elif (descGroup is not None and (descGroup.find("Built Environment") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Historic Interest") > -1)):
        returnVal = 3
    elif (descGroup is not None and (descGroup.find("Rail") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("General Feature") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Landform") > -1) and make == "Manmade"):
        returnVal = 1
    else:
        returnVal = 1

    logger.debug("Style Code:"+ str(returnVal))

    return returnVal
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# Calculates the color code value
def CalculateColorCode(row):
    descGroup = row[3]
    descTerm = row[4]
    make = row[5]
    returnVal = 99
    
    if descTerm is None:
        descTerm = ""

    if descGroup is None:
        descGroup = ""

    if (descGroup is not None and (descGroup.find("Buildings Or Structure") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Inland Water") > -1)):
        returnVal = 2
    elif (descGroup is not None and (descGroup.find("Road Or Track") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Terrain And Height") > -1)):
        returnVal = 3
    elif (descGroup is not None and (descGroup.find("Roadside") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Structure") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Political Or Administrative") > -1)):
        returnVal = 5
    elif (descGroup is not None and (descGroup.find("General Surface") > -1 and make == "Natural")):
        returnVal = 1
    elif ((descGroup is not None and (descGroup.find("General Surface") > -1 and make == "Manmade")) or (descGroup is not None and (descGroup.find("General Surface") > -1 and make is None))):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Landform") > -1) and make == "Natural"):
        returnVal = 4
    elif (descTerm is not None and (descTerm.find("Foreshore") > -1)):
        returnVal = 4
    elif (descGroup is not None and (descGroup.find("Tidal Water") > -1)):
        returnVal = 2
    elif (descGroup is not None and (descGroup.find("Built Environment") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Historic Interest") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Rail") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("General Feature") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Landform") > -1) and make == "Manmade"):
        returnVal = 4
    else:
        returnVal = 1

    logger.debug("Style Code:"+ str(returnVal))

    return returnVal
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# Calculates the style code value
def CalculateStyleCode(row):
    descGroup = row[3]
    descTerm = row[4]
    make = row[5]
    returnVal = 99

    if descTerm is None:
        descTerm = ""

    if descGroup is None:
        descGroup = ""

    if (descGroup is not None and (descGroup.find("Buildings Or Structure") > -1)):
        returnVal = 1
    elif (descGroup is not None and (descGroup.find("Inland Water") > -1)):
        returnVal = 2
    elif (descGroup is not None and (descGroup.find("Road Or Track") > -1)):
        returnVal = 3
    elif (descGroup is not None and (descGroup.find("Terrain And Height") > -1)):
        returnVal = 4
    elif (descGroup is not None and (descGroup.find("Roadside") > -1)):
        returnVal = 5
    elif (descGroup is not None and (descGroup.find("Structure") > -1)):
        returnVal = 6
    elif (descGroup is not None and (descGroup.find("Political Or Administrative") > -1)):
        returnVal = 7
    elif (descGroup is not None and (descGroup.find("General Surface") > -1 and make == "Natural")):
        returnVal = 8
    elif ((descGroup is not None and (descGroup.find("General Surface") > -1 and make == "Manmade")) or (descGroup is not None and (descGroup.find("General Surface") > -1 and make is None))):
        returnVal = 9
    elif (descGroup is not None and (descGroup.find("Landform") > -1) and make == "Natural"):
        returnVal = 10
    elif (descTerm is not None and (descTerm.find("Foreshore") > -1)):
        returnVal = 11
    elif (descGroup is not None and (descGroup.find("Tidal Water") > -1)):
        returnVal = 12
    elif (descGroup is not None and (descGroup.find("Built Environment") > -1)):
        returnVal = 13
    elif (descGroup is not None and (descGroup.find("Historic Interest") > -1)):
        returnVal = 14
    elif (descGroup is not None and (descGroup.find("Rail") > -1)):
        returnVal = 15
    elif (descGroup is not None and (descGroup.find("General Feature") > -1)):
        returnVal = 16
    elif (descGroup is not None and (descGroup.find("Landform") > -1) and make == "Manmade"):
        returnVal = 17
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
    make = row[5]
    returnVal = "Unclassified"

    if descTerm is None:
        descTerm = ""

    if descGroup is None:
        descGroup = ""

    if (descGroup is not None and (descGroup.find("Buildings Or Structure") > -1)):
        returnVal = "Building Text"
    elif (descGroup is not None and (descGroup.find("Inland Water") > -1)):
        returnVal = "Water Text"
    elif (descGroup is not None and (descGroup.find("Road Or Track") > -1)):
        returnVal = "Road Text"
    elif (descGroup is not None and (descGroup.find("Terrain And Height") > -1)):
        returnVal = "Height Text"
    elif (descGroup is not None and (descGroup.find("Roadside") > -1)):
        returnVal = "Roadside Text"
    elif (descGroup is not None and (descGroup.find("Structure") > -1)):
        returnVal = "Structure Text"
    elif (descGroup is not None and (descGroup.find("Political Or Administrative") > -1)):
        returnVal = "Administrative Text"
    elif (descGroup is not None and (descGroup.find("General Surface") > -1 and make == "Natural")):
        returnVal = "General Surface Natural Text"
    elif ((descGroup is not None and (descGroup.find("General Surface") > -1 and make == "Manmade")) or (descGroup is not None and (descGroup.find("General Surface") > -1 and make is None))):
        returnVal = "General Surface Manmade Text"
    elif (descGroup is not None and (descGroup.find("Landform") > -1) and make == "Natural"):
        returnVal = "Landform Natural Text"
    elif (descTerm is not None and (descTerm.find("Foreshore") > -1)):
        returnVal = "Foreshore Text"
    elif (descGroup is not None and (descGroup.find("Tidal Water") > -1)):
        returnVal = "Tidal Water Text"
    elif (descGroup is not None and (descGroup.find("Built Environment") > -1)):
        returnVal = "Built Environment Text"
    elif (descGroup is not None and (descGroup.find("Historic Interest") > -1)):
        returnVal = "Historic Text"
    elif (descGroup is not None and (descGroup.find("Rail") > -1)):
        returnVal = "Rail Text"
    elif (descGroup is not None and (descGroup.find("General Feature") > -1)):
        returnVal = "General Feature Text"
    elif (descGroup is not None and (descGroup.find("Landform") > -1) and make == "Manmade"):
        returnVal = "Landform Manmade Text"
    else:
        returnVal = "Unclassified"


    logger.debug("Style Description:"+ returnVal)

    return returnVal;
#-------------------------------------------------------------------------------