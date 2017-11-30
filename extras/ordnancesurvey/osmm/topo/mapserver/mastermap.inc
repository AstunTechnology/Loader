## Loader. Copyright (c) Astun Technology Ltd. (http://astuntechnology.com).
## Licensed under [MIT License](https://git.io/fAxH0).

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
			EXPRESSION "10053"
			STYLE
				#COLOR 255 255 204
				OUTLINECOLOR 212 212 212
			END
		END
		CLASS
			EXPRESSION ([featurecode] EQ 10111 OR [featurecode] == 20014 )
			STYLE
				#COLOR 204 255 153
				OUTLINECOLOR 212 212 212
			END
		END

		CLASS
			EXPRESSION "10056"
			STYLE
				#COLOR 204 255 153
				OUTLINECOLOR 212 212 212
			END
		END
		CLASS
			EXPRESSION "10054"
			STYLE
				#COLOR 204 204 153
				OUTLINECOLOR 212 212 212
			END
		END
		CLASS
			EXPRESSION "10172"
			STYLE
				COLOR 220 220 220
				OUTLINECOLOR 220 220 220
			END
		END
		CLASS
			EXPRESSION "10089"
			STYLE
				COLOR 224 238 253   
			END
		END
		CLASS
			EXPRESSION ([featurecode] EQ 20006 OR [featurecode] == 20022 )
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 212 212 212
				SYMBOL "0384"
			END
		END
		CLASS
			EXPRESSION "10123"
			STYLE
				COLOR 220 220 220
				OUTLINECOLOR 220 220 220
			END
		END
		CLASS
			EXPRESSION "10185"
			STYLE
				#COLOR 255 204 204  	
				OUTLINECOLOR 212 212 212
			END
		END
		CLASS
			EXPRESSION "20012"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 212 212 212
				SYMBOL "0392"
			END
		END
		CLASS
			EXPRESSION "20013"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 204 204 204
				SYMBOL "0379"
			END
		END
		CLASS
			EXPRESSION "20008"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 212 212 212
				SYMBOL "0386"
			END
		END
		CLASS
			EXPRESSION "20023"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 212 212 212
				SYMBOL "0390"
			END
		END
		CLASS
			EXPRESSION "10062"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 212 212 212
				SYMBOL "0323"
			END
		END
		CLASS
			EXPRESSION "10183"
			STYLE
				#COLOR 204 204 153
				OUTLINECOLOR 212 212 212
			END
		END
		CLASS
			EXPRESSION "20006"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 212 212 212
				SYMBOL "0385Scattered"
			END
		END
		CLASS
			EXPRESSION "20002"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 212 212 212
				SYMBOL "0382"
			END
		END
		CLASS
			EXPRESSION "0000"
			STYLE
				COLOR 0 0 0
				OUTLINECOLOR 255 255 255
				SYMBOL "0000RoadTrafficCalming"
			END
		END
		CLASS
			EXPRESSION "10145"
			STYLE
				#COLOR 255 255 153
				OUTLINECOLOR 212 212 212
			END
		END
		CLASS
			EXPRESSION "10167"
			STYLE
				COLOR 224 224 224
				OUTLINECOLOR 204 204 204
			END
		END
		CLASS
			EXPRESSION "20005"
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
			EXPRESSION ([featurecode] == 10017 OR [featurecode] == 10019 OR [featurecode] == 1002)
			STYLE
				COLOR 0 0 0
				WIDTH 1
			END
		END
		CLASS
			EXPRESSION "10019"
			STYLE
				COLOR 0 0 0
				WIDTH 1
			END
		END
		CLASS
			EXPRESSION "10023"
			STYLE
				COLOR 0 0 0
				WIDTH 1
			END
		END
		CLASS
			EXPRESSION "10113"
			STYLE

			END
		END
		CLASS
			EXPRESSION "10168"
			STYLE
				SYMBOL "dashed"
				SIZE 1
				COLOR 0 0 0
				PATTERN 2 2 END
			END
		END  	
		CLASS
			EXPRESSION "10173"
			STYLE
				SYMBOL "dashed"
				SIZE 1
				COLOR 0 0 0
			END
		END
		CLASS
			EXPRESSION "10018"
			STYLE
				COLOR 0 0 0
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
		DATA "wkb_geometry FROM (SELECT featurecode, wkb_geometry, textstring, ogc_fid, orientation/10 as orientdeg, CASE anchorposition WHEN 2 THEN 'lr' WHEN 5 THEN 'lc' WHEN 8 THEN 'll' WHEN 1 THEN 'cr' WHEN 4 THEN 'cc' WHEN 7 THEN 'cl' WHEN 0 THEN 'ur' WHEN 3 THEN 'uc' WHEN 6 THEN 'ul' END as position FROM mapping.cartographictext) AS foo USING UNIQUE ogc_fid  USING SRID=27700"   
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
