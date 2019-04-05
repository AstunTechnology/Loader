-- Loader. Copyright (c) Astun Technology Ltd. (http://astuntechnology.com).
-- Licensed under [MIT License](https://git.io/fAxH0).

-- Drops any existing VML related tables and creates fresh tables ready to
-- receive data.

DROP TABLE IF EXISTS "vml"."text" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'text' AND f_table_schema = 'vml';

CREATE TABLE "vml"."text" ( OGC_FID SERIAL, CONSTRAINT "text_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('vml','text','wkb_geometry',27700,'POINT',2);
ALTER TABLE "vml"."text" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "vml"."text" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "vml"."text" ADD COLUMN "featuredescription" VARCHAR;
ALTER TABLE "vml"."text" ADD COLUMN "anchorposition" INTEGER;
ALTER TABLE "vml"."text" ADD COLUMN "font" INTEGER;
ALTER TABLE "vml"."text" ADD COLUMN "height" FLOAT8;
ALTER TABLE "vml"."text" ADD COLUMN "orientation" INTEGER;
ALTER TABLE "vml"."text" ADD COLUMN "orientdeg" FLOAT8;
ALTER TABLE "vml"."text" ADD COLUMN "textstring" VARCHAR;

DROP TABLE IF EXISTS "vml"."vectormappoint" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'vectormappoint' AND f_table_schema = 'vml';

CREATE TABLE "vml"."vectormappoint" ( OGC_FID SERIAL, CONSTRAINT "vectormappoint_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('vml','vectormappoint','wkb_geometry',27700,'POINT',2);
ALTER TABLE "vml"."vectormappoint" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "vml"."vectormappoint" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "vml"."vectormappoint" ADD COLUMN "featuredescription" VARCHAR;
ALTER TABLE "vml"."vectormappoint" ADD COLUMN "orientation" INTEGER;
ALTER TABLE "vml"."vectormappoint" ADD COLUMN "orientdeg" FLOAT8;

DROP TABLE IF EXISTS "vml"."line" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'line' AND f_table_schema = 'vml';

CREATE TABLE "vml"."line" ( OGC_FID SERIAL, CONSTRAINT "line_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('vml','line','wkb_geometry',27700,'LINESTRING',2);
ALTER TABLE "vml"."line" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "vml"."line" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "vml"."line" ADD COLUMN "featuredescription" VARCHAR;

DROP TABLE IF EXISTS "vml"."roadcline" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'roadcline' AND f_table_schema = 'vml';

CREATE TABLE "vml"."roadcline" ( OGC_FID SERIAL, CONSTRAINT "roadcline_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('vml','roadcline','wkb_geometry',27700,'LINESTRING',2);
ALTER TABLE "vml"."roadcline" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "vml"."roadcline" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "vml"."roadcline" ADD COLUMN "featuredescription" VARCHAR;
ALTER TABLE "vml"."roadcline" ADD COLUMN "roadnumber" VARCHAR;
ALTER TABLE "vml"."roadcline" ADD COLUMN "roadname" VARCHAR;
ALTER TABLE "vml"."roadcline" ADD COLUMN "drawlevel" INTEGER;
ALTER TABLE "vml"."roadcline" ADD COLUMN "override" BOOLEAN;
ALTER TABLE "vml"."roadcline" ADD COLUMN "suppressed" BOOLEAN;
ALTER TABLE "vml"."roadcline" ADD COLUMN "intunnel" BOOLEAN;

DROP TABLE IF EXISTS "vml"."area" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'area' AND f_table_schema = 'vml';

CREATE TABLE "vml"."area" ( OGC_FID SERIAL, CONSTRAINT "area_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('vml','area','wkb_geometry',27700,'POLYGON',2);
ALTER TABLE "vml"."area" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "vml"."area" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "vml"."area" ADD COLUMN "featuredescription" VARCHAR;

DROP TABLE IF EXISTS "vml"."railcline" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'railcline' AND f_table_schema = 'vml';

CREATE TABLE "vml"."railcline" ( OGC_FID SERIAL, CONSTRAINT "railcline_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('vml','railcline','wkb_geometry',27700,'LINESTRING',2);
ALTER TABLE "vml"."railcline" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "vml"."railcline" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "vml"."railcline" ADD COLUMN "featuredescription" VARCHAR;
ALTER TABLE "vml"."railcline" ADD COLUMN "suppressed" BOOLEAN;
ALTER TABLE "vml"."railcline" ADD COLUMN "intunnel" BOOLEAN;
