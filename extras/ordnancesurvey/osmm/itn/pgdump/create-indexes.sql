-- Loader. Copyright (c) Astun Technology Ltd. (http://astuntechnology.com).
-- Licensed under [MIT License](https://git.io/fAxH0).

CREATE INDEX "roadlink_wkb_geometry_geom_idx" ON "osmm_itn"."roadlink" USING GIST ("wkb_geometry");
CREATE INDEX "roadnode_wkb_geometry_geom_idx" ON "osmm_itn"."roadnode" USING GIST ("wkb_geometry");
CREATE INDEX "ferrynode_wkb_geometry_geom_idx" ON "osmm_itn"."ferrynode" USING GIST ("wkb_geometry");
CREATE INDEX "informationpoint_wkb_geometry_geom_idx" ON "osmm_itn"."informationpoint" USING GIST ("wkb_geometry");
CREATE INDEX "roadlinkinformation_wkb_geometry_geom_idx" ON "osmm_itn"."roadlinkinformation" USING GIST ("wkb_geometry");
CREATE INDEX "roadrouteinformation_wkb_geometry_geom_idx" ON "osmm_itn"."roadrouteinformation" USING GIST ("wkb_geometry");
