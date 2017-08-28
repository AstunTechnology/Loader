-- Creates a spatial index for each table with geometry

CREATE INDEX "basiclandpropertyunit_wkb_geometry_geom_idx" ON "addressbase_premium"."basiclandpropertyunit" USING GIST ("wkb_geometry");
CREATE INDEX "street_wkb_geometry_geom_idx" ON "addressbase_premium"."street" USING GIST ("wkb_geometry");

