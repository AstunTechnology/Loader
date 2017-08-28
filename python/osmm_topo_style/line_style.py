#-------------------------------------------------------------------------------
# Name:        Topographic Line style
# Purpose:     Calculates the style description and code for lines.
#
# Author:      sbatterby
#
# Created:     04/02/2016
# Copyright:   (c) sbatterby 2016
#-------------------------------------------------------------------------------
import arcpy
import os
import logging

logger = logging.getLogger("style_debug")


#-------------------------------------------------------------------------------
# Calculates the style code value
def CalculateStyleCode(row):
    descTerm = row[3]
    descGroup = row[4]
    make = row[5]
    physicalPres = row[6]
    returnVal = 99

    if descTerm is None:
        descTerm = ""

    if descGroup is None:
        descGroup = ""

    if (descTerm == "Polygon Closing Link"):
        returnVal = 1
    elif (descTerm == "Inferred Property Closing Link"):
        returnVal = 2
    elif (descTerm == "Bottom Of Slope"):
        returnVal = 3
    elif (descTerm == "Top Of Slope"):
        returnVal = 4
    elif (descTerm == "Step"):
        returnVal = 5
    elif (descTerm is not None and descTerm.find("Mean High Water (Springs)") > -1):
        returnVal = 6
    elif (descTerm == "Traffic Calming"):
        returnVal = 7
    elif (descTerm == "Standard Gauge Track"):
        returnVal = 8
    elif (descTerm == "Bottom Of Cliff"):
        returnVal = 9
    elif (descTerm == "Top Of Cliff"):
        returnVal = 10
    elif (descTerm == "Mean Low Water (Springs)"):
        returnVal = 11
    elif (descTerm == "Unmade Path Alignment"):
        returnVal = 12
    elif (descTerm is not None and descTerm.find("Overhead Construction") > -1):
        returnVal = 13
    elif (descTerm == "Culvert"):
        returnVal = 14
    elif (descTerm == "Pylon"):
        returnVal = 15
    elif (descTerm == "Ridge Or Rock Line"):
        returnVal = 16
    elif (descTerm == "Narrow Gauge"):
        returnVal = 17
    elif (descTerm == "Buffer"):
        returnVal = 18
    elif (descTerm == "Tunnel Edge"):
        returnVal = 19
    elif (descTerm is not None and descTerm.find("Line Of Posts") > -1):
        returnVal = 20
    elif (descTerm == "Drain"):
        returnVal = 21
    elif (descTerm == "Normal Tidal Limit"):
        returnVal = 22


    # Descriptive group rules
    elif (descGroup is not None and descGroup.find("General Feature") > -1 and physicalPres != "Edge / Limit"):
        returnVal = 23
    elif (descGroup is not None and descGroup.find("Building") > -1 and descTerm == "Outline" and physicalPres == "Obstructing"):
        returnVal = 24
    elif (descGroup is not None and descGroup.find("General Feature") > -1 and physicalPres == "Edge / Limit"):
        returnVal = 25
    elif (descGroup == "Road Or Track"):
        returnVal = 26
    elif (descGroup is not None and descGroup.find("Building") > -1 and descTerm == "Division" and physicalPres == "Obstructing"):
        returnVal = 27
    elif (descGroup == "Inland Water"):
        returnVal = 28
    elif (descGroup is not None and descGroup.find("General Surface") > -1 and make == "Natural"):
        returnVal = 29
    elif (descGroup is not None and descGroup.find("Building") > -1 and descTerm == "Outline" and physicalPres == "Overhead"):
        returnVal = 30
    elif (descGroup == "Landform" and make == "Natural"):
        returnVal = 31
    elif (descGroup == "Historic Interest"):
        returnVal = 32
    elif (descGroup == "Landform" and make == "Manmade"):
        returnVal = 33
    else:
        returnVal = 99

    logger.debug("Style Code:"+ str(returnVal))

    return returnVal
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# Calculates the style description value
def CalculateStyleDescription(row):
    descTerm = row[3]
    descGroup = row[4]
    make = row[5]
    physicalPres = row[6]
    returnVal = "Unclassified"

    if descTerm is None:
        descTerm = ""

    if descGroup is None:
        descGroup = ""

    if (descTerm == "Polygon Closing Link"):
        returnVal = "Polygon Closing Line"
    elif (descTerm == "Inferred Property Closing Link"):
        returnVal = "Property Closing Line"
    elif (descTerm == "Bottom Of Slope"):
        returnVal = "Bottom Of Slope Line"
    elif (descTerm == "Top Of Slope"):
        returnVal = "Top Of Slope Line"
    elif (descTerm == "Step"):
        returnVal = "Step Line"
    elif (descTerm is not None and descTerm.find("Mean High Water (Springs)") > -1):
        returnVal = "Mean High Water Line"
    elif (descTerm == "Traffic Calming"):
        returnVal = "Traffic Calming Line"
    elif (descTerm == "Standard Gauge Track"):
        returnVal = "Standard Gauge Track Line"
    elif (descTerm == "Bottom Of Cliff"):
        returnVal = "Bottom Of Cliff Line"
    elif (descTerm == "Top Of Cliff"):
        returnVal = "Top Of Cliff Line"
    elif (descTerm == "Mean Low Water (Springs)"):
        returnVal = "Mean Low Water Line"
    elif (descTerm == "Unmade Path Alignment"):
        returnVal = "Path Line"
    elif (descTerm is not None and descTerm.find("Overhead Construction") > -1):
        returnVal = "Overhead Construction Line"
    elif (descTerm == "Culvert"):
        returnVal = "Culvert Line"
    elif (descTerm == "Pylon"):
        returnVal = "Pylon Line"
    elif (descTerm == "Ridge Or Rock Line"):
        returnVal = "Ridge Or Rock Line"
    elif (descTerm == "Narrow Gauge"):
        returnVal = "Narrow Gauge Line"
    elif (descTerm == "Buffer"):
        returnVal = "Railway Buffer Line"
    elif (descTerm == "Tunnel Edge"):
        returnVal = "Tunnel Edge Line"
    elif (descTerm is not None and descTerm.find("Line Of Posts") > -1):
        returnVal = "Line Of Posts Line"
    elif (descTerm == "Drain"):
        returnVal = "Drain Line"
    elif (descTerm == "Normal Tidal Limit"):
        returnVal = "Normal Tidal Limit Line"
    # Descriptive group rules
    elif (descGroup is not None and descGroup.find("General Feature") > -1 and physicalPres != "Edge / Limit"):
        returnVal = "Default Line"
    elif (descGroup is not None and descGroup.find("Building") > -1 and descTerm == "Outline" and physicalPres == "Obstructing"):
        returnVal = "Building Outline Line"
    elif (descGroup is not None and descGroup.find("General Feature") > -1 and physicalPres == "Edge / Limit"):
        returnVal = "Edge Line"
    elif (descGroup == "Road Or Track"):
        returnVal = "Road Or Track Line"
    elif (descGroup is not None and descGroup.find("Building") > -1 and descTerm == "Division" and physicalPres == "Obstructing"):
        returnVal = "Building Division Line"
    elif (descGroup == "Inland Water"):
        returnVal = "Inland Water Line"
    elif (descGroup is not None and descGroup.find("General Surface") > -1 and make == "Natural"):
        returnVal = "General Surface Natural Line"
    elif (descGroup is not None and descGroup.find("Building") > -1 and descTerm == "Outline" and physicalPres == "Overhead"):
        returnVal = "Building Overhead Line"
    elif (descGroup == "Landform" and make == "Natural"):
        returnVal = "Landform Natural Line"
    elif (descGroup == "Historic Interest"):
        returnVal = "Historic Interest Line"
    elif (descGroup == "Landform" and make == "Manmade"):
        returnVal = "Landform Manmade Line"
    else:
        returnVal = "Unclassified"

    logger.debug("Style Description:"+ returnVal)

    return returnVal;
#-------------------------------------------------------------------------------





