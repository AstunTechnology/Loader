-- Creates a spatial index for each VML table.

CREATE INDEX "text_geom_idx" ON "vml"."text" USING GIST ("wkb_geometry");
CREATE INDEX "vectormappoint_geom_idx" ON "vml"."vectormappoint" USING GIST ("wkb_geometry");
CREATE INDEX "line_geom_idx" ON "vml"."line" USING GIST ("wkb_geometry");
CREATE INDEX "roadcline_geom_idx" ON "vml"."roadcline" USING GIST ("wkb_geometry");
CREATE INDEX "area_geom_idx" ON "vml"."area" USING GIST ("wkb_geometry");
