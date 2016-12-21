#-------------------------------------------------------------------------------
# Name:        Cartographic symbol style
# Purpose:
#
# Author:      sbatterby
#
# Created:     08/02/2016
# Copyright:   (c) sbatterby 2016
#-------------------------------------------------------------------------------

import arcpy
import os
import logging

logger = logging.getLogger("style_debug")


#-------------------------------------------------------------------------------
# Calculates the style code value
def CalculateStyleCode(row):
    featureCode = row[3]
    returnVal = 99

    if (featureCode == 10091):
        returnVal = 1
    elif (featureCode == 10082):
        returnVal = 2
    elif (featureCode == 10130):
        returnVal = 3
    elif (featureCode == 10066 or featureCode == 10170):
        returnVal = 4
    elif (featureCode == 10165):
        returnVal = 5
    elif (featureCode == 10177):
        returnVal = 6
    else:
        returnVal = 99

    logger.debug("Style Code:"+ str(returnVal))

    return returnVal
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# Calculates the style description value
def CalculateStyleDescription(row):
    featureCode = row[3]
    returnVal = "Unclassified"


    if (featureCode == 10091):
        returnVal = "Culvert Symbol"
    elif (featureCode == 10082):
        returnVal = "Direction Of Flow Symbol"
    elif (featureCode == 10130):
        returnVal = "Boundary Half Mereing Symbol"
    elif (featureCode == 10066 or featureCode == 10170):
        returnVal = "Bench Mark Symbol"
    elif (featureCode == 10165):
        returnVal = "Railway Switch Symbol"
    elif (featureCode == 10177):
        returnVal = "Road Related Flow Symbol"
    else:
        returnVal = "Unclassified"


    logger.debug("Style Description:"+ returnVal)

    return returnVal;
#-------------------------------------------------------------------------------