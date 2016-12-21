#-------------------------------------------------------------------------------
# Name:        Boundary Line Style
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


#-------------------------------------------------------------------------------
# Calculates the style code value
def CalculateStyleCode(row):
    featureCode = row[3]
    returnVal = 99

    if (featureCode == 10136):
        returnVal = 1
    elif (featureCode == 10131):
        returnVal = 2
    elif (featureCode == 10128):
        returnVal = 3
    elif (featureCode == 10127):
        returnVal = 4
    elif (featureCode == 10135):
        returnVal = 5
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

    if (featureCode == 10136):
        returnVal = "Parish Boundary"
    elif (featureCode == 10131):
        returnVal = "District Boundary"
    elif (featureCode == 10128):
        returnVal = "Electoral Boundary"
    elif (featureCode == 10127):
        returnVal = "County Boundary"
    elif (featureCode == 10135):
        returnVal = "Parliamentary Boundary"
    else:
        returnVal = "Unclassified"


    logger.debug("Style Description:"+ returnVal)

    return returnVal;
#-------------------------------------------------------------------------------