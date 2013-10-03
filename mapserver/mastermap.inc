LAYER
		METADATA
			 WMS_TITLE "TopoArea"        
		END
		GROUP "base_OS"
		NAME TopoArea
		TYPE POLYGON
		STATUS DEFAULT
		INCLUDE "pg_connection.inc"
		PROCESSING "CLOSE_CONNECTION=DEFER"
		DATA "wkb_geometry FROM (SELECT wkb_geometry, featurecode, ogc_fid FROM mapping.topographicarea) AS FOO USING UNIQUE ogc_fid  USING SRID=27700"
		MINSCALEDENOM 1
		MAXSCALEDENOM 2500
		SYMBOLSCALEDENOM 1200
		OPACITY 40
		CLASSITEM "featurecode"
		CLASS
			EXPRESSION "10021" #Building Fill
			STYLE
				COLOR 252 226 197
				OUTLINECOLOR 0 0 0
			END
		END
		CLASS
			EXPRESSION "10053" #"0000 Multiple surface (garden)"
			STYLE
				#COLOR 255 255 204
				OUTLINECOLOR 212 212 212
			END
		END
		CLASS
			EXPRESSION ([featurecode] EQ 10111 OR [featurecode] == 20014 ) # "0000 Natural surface"
			STYLE
				#COLOR 204 255 153
				OUTLINECOLOR 212 212 212
			END
		END

		CLASS
			EXPRESSION "10056" # "0000 Manmade surface"
			STYLE
				#COLOR 204 255 153
				OUTLINECOLOR 212 212 212
			END
		END
		CLASS
			EXPRESSION "10054" #"0000 Manmade surface or step"
			STYLE
				#COLOR 204 204 153
				OUTLINECOLOR 212 212 212
			END
		END
		CLASS
			EXPRESSION "10172" #"0000 Road"
			STYLE
				COLOR 220 220 220
				OUTLINECOLOR 220 220 220
			END
		END
		CLASS
			EXPRESSION "10089" #"0400 Inland water"
			STYLE
				COLOR 224 238 253   
			END
		END
		CLASS
			EXPRESSION ([featurecode] EQ 20006 OR [featurecode] == 20022 ) #"0384 Nonconiferous trees"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 212 212 212
				SYMBOL "0384"
			END
		END
		CLASS
			EXPRESSION "10123" #"0000 Path or track"
			STYLE
				COLOR 220 220 220
				OUTLINECOLOR 220 220 220
			END
		END
		CLASS
			EXPRESSION "10185" #"0000 Structure"
			STYLE
				#COLOR 255 204 204  	
				OUTLINECOLOR 212 212 212
			END
		END
		CLASS
			EXPRESSION "20012" # "0392 Scrub"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 212 212 212
				SYMBOL "0392"
			END
		END
		CLASS
			EXPRESSION "20013" #"0379 Coniferous Trees"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 204 204 204
				SYMBOL "0379"
			END
		END
		CLASS
			EXPRESSION "20008" #"0386 Orchard"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 212 212 212
				SYMBOL "0386"
			END
		END
		CLASS
			EXPRESSION "20023" # multiple - "0390 Rough grassland"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 212 212 212
				SYMBOL "0390"
			END
		END
		CLASS
			EXPRESSION "10062" # "0323 Glasshouse"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 212 212 212
				SYMBOL "0323"
			END
		END
		CLASS
			EXPRESSION "10183" # ??"0000 Unknown surface"
			STYLE
				#COLOR 204 204 153
				OUTLINECOLOR 212 212 212
			END
		END
		CLASS
			EXPRESSION "20006" #"0385 Nonconiferous - scattered"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 212 212 212
				SYMBOL "0385Scattered"
			END
		END
		CLASS
			EXPRESSION "20002" #"0382 Marsh reeds or saltmarsh"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 212 212 212
				SYMBOL "0382"
			END
		END
		CLASS
			EXPRESSION "0000" #Road traffic calming
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 255 255 255
				SYMBOL "0000RoadTrafficCalming"
			END
		END
		CLASS
			EXPRESSION "10145" #"0000 Unclassified (or broken)"
			STYLE
				#COLOR 255 255 153
				OUTLINECOLOR 212 212 212
			END
		END
		CLASS
			EXPRESSION "10167" #"0000 Railway"
			STYLE
				COLOR 224 224 224
				OUTLINECOLOR 204 204 204
			END
		END
		CLASS
			EXPRESSION "20005" #"0380 Coniferous - scattered"
			STYLE
				#COLOR 224 224 224
				OUTLINECOLOR 212 212 212
				SYMBOL "0380Scattered"
			END
		END
		CLASS
			EXPRESSION ""
			STYLE
				#COLOR 204 253 157
				OUTLINECOLOR 212 212 212
			END
		END
	END

	LAYER      
		METADATA
			 WMS_TITLE "TopoLine"   
		END     
		GROUP "base_OS"
		NAME TopoLine
		TYPE LINE
		STATUS DEFAULT
		INCLUDE "pg_connection.inc"
		DATA "wkb_geometry FROM (SELECT featurecode, wkb_geometry, ogc_fid FROM mapping.topographicline) AS FOO USING UNIQUE ogc_fid  USING SRID=27700"
		PROCESSING "CLOSE_CONNECTION=DEFER"
		MINSCALEDENOM 1
		MAXSCALEDENOM 2500
		SYMBOLSCALEDENOM 1200
		OPACITY 50
		CLASSITEM "featurecode"
		CLASS
			EXPRESSION "0030 Obstructing feature"
			STYLE
				COLOR 212 212 212
			END
		END
		#([FEATURECODE] == 10102 OR [FEATURECODE] == 10133)
		CLASS
			EXPRESSION ([featurecode] == 10017 OR [featurecode] == 10019 OR [featurecode] == 1002) #"0001 Building outline"
			STYLE
				COLOR 0 0 0
				WIDTH 1
			END
		END
		CLASS
			EXPRESSION "10019" #"0001 Building outline"
			STYLE
				COLOR 0 0 0
				WIDTH 1
			END
		END
		CLASS
			EXPRESSION "10023" #"0001 Building outline"
			STYLE
				COLOR 0 0 0
				WIDTH 1
			END
		END
		CLASS
			EXPRESSION "10113" #"0032 Path line or edge / limit"
			STYLE

			END
		END
		CLASS
			EXPRESSION "10168" #"0032 Path line or edge / limit"
			STYLE
				SYMBOL "dashed"
				SIZE 1
				COLOR 0 0 0
				PATTERN 2 2 END
			END
		END  	
		CLASS
			EXPRESSION "10173" #"0021 Road or track edge"
			STYLE
				SYMBOL "dashed"
				SIZE 1
				COLOR 0 0 0
			END
		END
		CLASS
			EXPRESSION "0059 Inland water edge / limit"
			STYLE
				COLOR 224 238 253
			END
		END
		CLASS
			EXPRESSION "10018" #"0030 Building division"
			STYLE
				COLOR 0 0 0
			END
		END
		CLASS
			EXPRESSION "0000 Polygon closing link"
			STYLE
				COLOR 212 212 212
			END
		END
		CLASS
			EXPRESSION "0000 Property closing inferred"
			STYLE
				COLOR 212 212 212
			END
		END
		CLASS
			EXPRESSION "0004 Building outline - o'head"
			STYLE
				COLOR 0 0 0
				WIDTH 2
				SYMBOL "line-dots"
				PATTERN 1 5 1 5 END
			END
		END
		CLASS
			STYLE
				COLOR 153 153 153
			END
		END
	END

	LAYER      
		METADATA
			 WMS_TITLE "CartoText"
		END
		GROUP "base_OS"
		NAME CartoText
		TYPE ANNOTATION
		STATUS DEFAULT
		INCLUDE "pg_connection.inc"
		DATA "wkb_geometry FROM (SELECT featurecode, wkb_geometry, textstring, ogc_fid, orientdeg, CASE anchorposition WHEN 2 THEN 'lr' WHEN 5 THEN 'lc' WHEN 8 THEN 'll' WHEN 1 THEN 'cr' WHEN 4 THEN 'cc' WHEN 7 THEN 'cl' WHEN 0 THEN 'ur' WHEN 3 THEN 'uc' WHEN 6 THEN 'ul' END as position FROM mapping.cartographictext) AS foo USING UNIQUE ogc_fid  USING SRID=27700"   
		LABELITEM "textstring"
		MINSCALEDENOM 1
		MAXSCALEDENOM 2500
		SYMBOLSCALEDENOM 1200
		OPACITY 50
		CLASSITEM "featurecode"
		CLASS
			EXPRESSION ([featurecode] == 10026 OR [featurecode] == 10166 OR [featurecode] == 10178 OR [featurecode] == 10184)
			LABEL
				FONT "arial"
				TYPE TRUETYPE
				COLOR 0 0 0
				OUTLINECOLOR 255 255 255
				SIZE 7
				POSITION [position]
				OFFSET 0 -5
				ANGLE [orientdeg]
			END  		
		END
		CLASS
			EXPRESSION ([featurecode] == 10033)
			LABEL
				FONT "arialbd"
				TYPE TRUETYPE
				COLOR 153 153 153
				SIZE 10
				POSITION [position]
				ANGLE [orientdeg]
			END  		
		END
		CLASS
			EXPRESSION ([featurecode] == 10043)
			LABEL
				FONT "arialbd"
				TYPE TRUETYPE
				COLOR 0 0 0
				SIZE 8
				POSITION [position]
				ANGLE [orientdeg]
			END  		
		END
		CLASS
			EXPRESSION ([featurecode] == 10059)
			LABEL
				FONT "arial"
				TYPE TRUETYPE
				COLOR 0 0 0
				SIZE 8
				POSITION [position]
				ANGLE [orientdeg]
			END  		
		END  	
		CLASS
			EXPRESSION ([featurecode] == 10069)
			LABEL
				FONT "ariali"
				TYPE TRUETYPE
				COLOR 0 0 0
				SIZE 6
				POSITION [position]
				ANGLE [orientdeg]
			END  		
		END  	
		CLASS
			EXPRESSION ([featurecode] == 10074)
			LABEL
				FONT "ariali"
				TYPE TRUETYPE
				COLOR 0 0 0
				SIZE 9
				POSITION [position]
				ANGLE [orientdeg]
			END  		
		END  		
		CLASS
			EXPRESSION ([featurecode] == 10090)
			LABEL
				FONT "ariali"
				TYPE TRUETYPE
				COLOR 0 02 0
				SIZE 8
				POSITION [position]
				ANGLE [orientdeg]
			END  		
		END
		CLASS
			EXPRESSION ([featurecode] == 10102 OR [featurecode] == 10133)
			LABEL
				FONT "arial"
				TYPE TRUETYPE
				COLOR 0 0 0
				SIZE 6
				POSITION [position]
				ANGLE [orientdeg]
			END  		
		END
		CLASS
			EXPRESSION ([featurecode] == 10169)
			LABEL
				FONT "arialbd"
				TYPE TRUETYPE
				ANTIALIAS TRUE
				COLOR 0 0 0
				OUTLINECOLOR 255 255 255
				SIZE 8
				POSITION [position]
				ANGLE [orientdeg]
			END  		
		END
		CLASS
			EXPRESSION ([featurecode] == 10198)
			LABEL
				FONT "arial"
				TYPE TRUETYPE
				ANTIALIAS TRUE
				COLOR 0 0 0
				SIZE 7
				POSITION [position]
				ANGLE [orientdeg]
			END  		
		END  		
	END
