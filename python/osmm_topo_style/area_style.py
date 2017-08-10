#-------------------------------------------------------------------------------------------------------------------
# Name:        Topographic Area Style
# Purpose:
#
# Author:      sbatterby
#
# Created:     05/02/2016
# Copyright:   (c) sbatterby 2016
#-------------------------------------------------------------------------------------------------------------------

import arcpy
import os
import logging

logger = logging.getLogger("style_debug")


#-------------------------------------------------------------------------------------------------------------------
# Calculates the style code value
def CalculateStyleCode(row):
    descTerm = row[3]
    descGroup = row[4]
    make = row[5]
    returnVal = 99

    if descTerm is None:
        descTerm = ""

    if descGroup is None:
        descGroup = ""

    if (descTerm == "Multi Surface"):
        returnVal = 1
    elif (descTerm == "Archway"):
        returnVal = 2
    elif (descTerm is not None and descTerm.find("Bridge") > -1 and (descGroup.find("Road Or Track") > -1 or descGroup.find("Roadside") > -1)):
        returnVal = 3
    elif (descTerm is not None and descTerm.find("Bridge") > -1 and descGroup.find("Rail") > -1):
        returnVal = 4
    elif (descTerm is not None and descTerm.find("Bridge") > -1):
        returnVal = 5
    elif (descTerm is not None and descTerm.find("Level Crossing") > -1):
        returnVal = 6
    elif (descTerm == "Traffic Calming"):
        returnVal = 7
    elif (descTerm == "Pylon"):
        returnVal = 8
    elif (descTerm == "Track"):
        returnVal = 9
    elif (descTerm == "Step"):
        returnVal = 10
    elif (descTerm == "Canal"):
        returnVal = 11
    elif (descTerm == "Footbridge"):
        returnVal = 12

    # Natural Environment Descriptive Term Rules
    elif (descTerm is not None and (descTerm.find("Nonconiferous Trees") > -1 or descTerm.find("Nonconiferous Trees (Scattered)") > -1) and (descTerm.find("Coniferous Trees") > -1 or descTerm.find("Coniferous Trees (Scattered)") > -1)):
        returnVal = 13
    elif (descTerm is not None and descTerm.find("Nonconiferous Trees") > -1 or descTerm.find("Nonconiferous Trees (Scattered)") > -1):
        returnVal = 14
    elif (descTerm is not None and descTerm.find("Coniferous Trees") > -1 or descTerm.find("Coniferous Trees (Scattered)") > -1):
        returnVal = 15
    elif (descTerm is not None and descTerm.find("Agricultural Land") > -1):
        returnVal = 16
    elif (descTerm.find("Orchard") > -1):
        returnVal = 17
    elif (descTerm.find("Coppice Or Osiers") > -1):
        returnVal = 18
    elif (descTerm.find("Scrub") > -1):
        returnVal = 19
    elif (descTerm.find("Boulders") > -1 or descTerm.find("Boulders (Scattered)") > -1):
        returnVal = 20
    elif (descTerm.find("Rock") > -1 or descTerm.find("Rock (Scattered)") > -1):
        returnVal = 21
    elif (descTerm.find("Scree") > -1):
        returnVal = 22
    elif (descTerm.find("Rough Grassland") > -1):
        returnVal = 23
    elif (descTerm.find("Heath") > -1):
        returnVal = 24
    elif (descTerm.find("Marsh Reeds Or Saltmarsh") > -1 or descTerm.find("Saltmarsh") > -1):
        returnVal = 25
    elif (descTerm.find("Sand") > -1):
        returnVal = 26
    elif (descTerm.find("Mud") > -1):
        returnVal = 27
    elif (descTerm.find("Shingle") > -1):
        returnVal = 28
    elif (descTerm.find("Marsh") > -1):
        returnVal = 29
    elif (descTerm.find("Reeds") > -1):
        returnVal = 30
    elif (descTerm.find("Foreshore") > -1):
        returnVal = 31
    elif (descTerm.find("Slope") > -1):
        returnVal = 32
    elif (descTerm.find("Cliff") > -1):
        returnVal = 33

    # Descriptive group rules
    elif (descGroup.find("Building") > -1):
        returnVal = 34
    elif (descGroup.find("General Surface") > -1 and make == "Natural"):
        returnVal = 35
    elif (descGroup.find("General Surface") > -1 and (make == "Manmade" or make == "Unknown")):
        returnVal = 36
    elif (descGroup.find("Road Or Track") > -1 and make == "Manmade"):
        returnVal = 37
    elif (descGroup.find("Roadside") > -1 and make == "Natural"):
        returnVal = 38
    elif (descGroup.find("Roadside") > -1 and (make == "Manmade" or make == "Unknown")):
        returnVal = 39
    elif (descGroup.find("Inland Water") > -1):
        returnVal = 40
    elif (descGroup.find("Path") > -1):
        returnVal = 41
    elif (descGroup.find("Rail") > -1 and (make == "Manmade" or make == "Unknown")):
        returnVal = 42
    elif (descGroup.find("Rail") > -1 and make == "Natural"):
        returnVal = 43
    elif (descGroup.find("Structure") > -1):
        returnVal = 44
    elif (descGroup == "Glasshouse"):
        returnVal = 45
    elif (descGroup.find("Landform") > -1 and make == "Natural"):
        returnVal = 46
    elif (descGroup.find("Tidal Water") > -1):
        returnVal = 47
    elif (descGroup.find("Landform") > -1 and make == "Manmade"):
        returnVal = 48
    else:
        returnVal = 99

    logger.debug("Style Code:"+ str(returnVal))

    return returnVal
#-------------------------------------------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------------------------------------
# Calculates the style description value
def CalculateStyleDescription(row):
    descTerm = row[3]
    descGroup = row[4]
    make = row[5]
    returnVal = "Unclassified"

    if descTerm is None:
        descTerm = ""

    if descGroup is None:
        descGroup = ""

    if (descTerm == "Multi Surface"):
        returnVal = "Multi Surface Fill"
    elif (descTerm == "Archway"):
        returnVal = "Archway Fill"
    elif (descTerm.find("Bridge") > -1 and (descGroup.find("Road Or Track") > -1 or descGroup.find("Roadside") > -1)):
        returnVal = "Road Bridge Fill"
    elif (descTerm.find("Bridge") > -1 and descGroup.find("Rail") > -1):
        returnVal = "Rail Bridge Fill"
    elif (descTerm.find("Bridge") > -1):
        returnVal = "Bridge Fill"
    elif (descTerm.find("Level Crossing") > -1):
        returnVal = "Level Crossing Fill"
    elif (descTerm == "Traffic Calming"):
        returnVal = "Traffic Calming Fill"
    elif (descTerm == "Pylon"):
        returnVal = "Pylon Fill"
    elif (descTerm == "Track"):
        returnVal = "Track Fill"
    elif (descTerm == "Step"):
        returnVal = "Step Fill"
    elif (descTerm == "Canal"):
        returnVal = "Canal Fill"
    elif (descTerm == "Footbridge"):
        returnVal = "Footbridge Fill"

    # Natural Environment Descriptive Term Rules
    elif ((descTerm.find("Nonconiferous Trees") > -1 or descTerm.find("Nonconiferous Trees (Scattered)") > -1) and (descTerm.find("Coniferous Trees") > -1 or descTerm.find("Coniferous Trees (Scattered)") > -1)):
        returnVal = "Mixed Woodland Fill"
    elif (descTerm.find("Nonconiferous Trees") > -1 or descTerm.find("Nonconiferous Trees (Scattered)") > -1):
        returnVal = "Nonconiferous Tree Fill"
    elif (descTerm.find("Coniferous Trees") > -1 or descTerm.find("Coniferous Trees (Scattered)") > -1):
        returnVal = "Coniferous Tree Fill"
    elif (descTerm.find("Agricultural Land") > -1):
        returnVal = "Agricultural Land Fill"
    elif (descTerm.find("Orchard") > -1):
        returnVal = "Orchard Fill"
    elif (descTerm.find("Coppice Or Osiers") > -1):
        returnVal = "Coppice Or Osiers Fill"
    elif (descTerm.find("Scrub") > -1):
        returnVal = "Scrub Fill"
    elif (descTerm.find("Boulders") > -1 or descTerm.find("Boulders (Scattered)") > -1):
        returnVal = "Boulders Fill"
    elif (descTerm.find("Rock") > -1 or descTerm.find("Rock (Scattered)") > -1):
        returnVal = "Rock Fill"
    elif (descTerm.find("Scree") > -1):
        returnVal = "Scree Fill"
    elif (descTerm.find("Rough Grassland") > -1):
        returnVal = "Rough Grassland Fill"
    elif (descTerm.find("Heath") > -1):
        returnVal = "Heath Fill"
    elif (descTerm.find("Marsh Reeds Or Saltmarsh") > -1 or descTerm.find("Saltmarsh") > -1):
        returnVal = "Marsh Fill"
    elif (descTerm.find("Sand") > -1):
        returnVal = "Sand Fill"
    elif (descTerm.find("Mud") > -1):
        returnVal = "Mud Fill"
    elif (descTerm.find("Shingle") > -1):
        returnVal = "Shingle Fill"
    elif (descTerm.find("Marsh") > -1):
        returnVal = "Marsh Fill"
    elif (descTerm.find("Reeds") > -1):
        returnVal = "Reeds Fill"
    elif (descTerm.find("Foreshore") > -1):
        returnVal = "Foreshore Fill"
    elif (descTerm.find("Slope") > -1):
        returnVal = "Slope Fill"
    elif (descTerm.find("Cliff") > -1):
        returnVal = "Cliff Fill"

    # Descriptive group rules
    elif (descGroup.find("Building") > -1):
        returnVal = "Building Fill"
    elif (descGroup.find("General Surface") > -1 and make == "Natural"):
        returnVal = "Natural Fill"
    elif (descGroup.find("General Surface") > -1 and (make == "Manmade" or make == "Unknown")):
        returnVal = "Manmade Fill"
    elif (descGroup.find("Road Or Track") > -1 and make == "Manmade"):
        returnVal = "Road Or Track Fill"
    elif (descGroup.find("Roadside") > -1 and make == "Natural"):
        returnVal = "Roadside Natural Fill"
    elif (descGroup.find("Roadside") > -1 and (make == "Manmade" or make == "Unknown")):
        returnVal = "Roadside Manmade Fill"
    elif (descGroup.find("Inland Water") > -1):
        returnVal = "Inland Water Fill"
    elif (descGroup.find("Path") > -1):
        returnVal = "Path Fill"
    elif (descGroup.find("Rail") > -1 and (make == "Manmade" or make == "Unknown")):
        returnVal = "Rail Manmade Fill"
    elif (descGroup.find("Rail") > -1 and make == "Natural"):
        returnVal = "Rail Natural Fill"
    elif (descGroup.find("Structure") > -1):
        returnVal = "Structure Fill"
    elif (descGroup == "Glasshouse"):
        returnVal = "Glasshouse Fill"
    elif (descGroup.find("Landform") > -1 and make == "Natural"):
        returnVal = "Landform Natural Fill"
    elif (descGroup.find("Tidal Water") > -1):
        returnVal = "Tidal Water Fill"
    elif (descGroup.find("Landform") > -1 and make == "Manmade"):
        returnVal = "Landform Manmade Fill"

    else:
        returnVal = "Unclassified"


    logger.debug("Style Description:"+ returnVal)

    return returnVal;
#-------------------------------------------------------------------------------------------------------------------