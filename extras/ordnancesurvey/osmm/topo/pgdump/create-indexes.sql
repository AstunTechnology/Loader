-- Creates a spatial index for each OSMM Topo table

CREATE INDEX "boundaryline_geom_idx" ON "osmm_topo"."boundaryline" USING GIST ("wkb_geometry");
CREATE INDEX "cartographicsymbol_geom_idx" ON "osmm_topo"."cartographicsymbol" USING GIST ("wkb_geometry");
CREATE INDEX "cartographictext_geom_idx" ON "osmm_topo"."cartographictext" USING GIST ("wkb_geometry");
CREATE INDEX "topographicarea_geom_idx" ON "osmm_topo"."topographicarea" USING GIST ("wkb_geometry");
CREATE INDEX "topographicline_geom_idx" ON "osmm_topo"."topographicline" USING GIST ("wkb_geometry");
CREATE INDEX "topographicpoint_geom_idx" ON "osmm_topo"."topographicpoint" USING GIST ("wkb_geometry");
