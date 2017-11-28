-- Drops any existing OSMM Topo related tables and creates fresh tables ready to receive data

DROP TABLE IF EXISTS "osmm_topo"."boundaryline" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'boundaryline' AND f_table_schema = 'osmm_topo';

CREATE TABLE "osmm_topo"."boundaryline" ( OGC_FID SERIAL, CONSTRAINT "boundaryline_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('osmm_topo','boundaryline','wkb_geometry',27700,'MULTILINESTRING',2);
ALTER TABLE "osmm_topo"."boundaryline" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_topo"."boundaryline" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "osmm_topo"."boundaryline" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_topo"."boundaryline" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_topo"."boundaryline" ADD COLUMN "theme" VARCHAR[];
ALTER TABLE "osmm_topo"."boundaryline" ADD COLUMN "accuracyofposition" VARCHAR;
ALTER TABLE "osmm_topo"."boundaryline" ADD COLUMN "changedate" VARCHAR[];
ALTER TABLE "osmm_topo"."boundaryline" ADD COLUMN "reasonforchange" VARCHAR[];
ALTER TABLE "osmm_topo"."boundaryline" ADD COLUMN "descriptivegroup" VARCHAR[];
ALTER TABLE "osmm_topo"."boundaryline" ADD COLUMN "descriptiveterm" VARCHAR[];
ALTER TABLE "osmm_topo"."boundaryline" ADD COLUMN "make" VARCHAR;
ALTER TABLE "osmm_topo"."boundaryline" ADD COLUMN "physicallevel" INTEGER;
ALTER TABLE "osmm_topo"."boundaryline" ADD COLUMN "physicalpresence" VARCHAR;
ALTER TABLE "osmm_topo"."boundaryline" ADD COLUMN "filename" VARCHAR;

DROP TABLE IF EXISTS "osmm_topo"."cartographicsymbol" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'cartographicsymbol' AND f_table_schema = 'osmm_topo';

CREATE TABLE "osmm_topo"."cartographicsymbol" ( OGC_FID SERIAL, CONSTRAINT "cartographicsymbol_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('osmm_topo','cartographicsymbol','wkb_geometry',27700,'POINT',2);
ALTER TABLE "osmm_topo"."cartographicsymbol" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_topo"."cartographicsymbol" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "osmm_topo"."cartographicsymbol" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_topo"."cartographicsymbol" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_topo"."cartographicsymbol" ADD COLUMN "theme" VARCHAR[];
ALTER TABLE "osmm_topo"."cartographicsymbol" ADD COLUMN "changedate" VARCHAR[];
ALTER TABLE "osmm_topo"."cartographicsymbol" ADD COLUMN "reasonforchange" VARCHAR[];
ALTER TABLE "osmm_topo"."cartographicsymbol" ADD COLUMN "descriptivegroup" VARCHAR[];
ALTER TABLE "osmm_topo"."cartographicsymbol" ADD COLUMN "descriptiveterm" VARCHAR[];
ALTER TABLE "osmm_topo"."cartographicsymbol" ADD COLUMN "orientation" INTEGER;
ALTER TABLE "osmm_topo"."cartographicsymbol" ADD COLUMN "physicallevel" INTEGER;
ALTER TABLE "osmm_topo"."cartographicsymbol" ADD COLUMN "physicalpresence" VARCHAR;
ALTER TABLE "osmm_topo"."cartographicsymbol" ADD COLUMN "referencetofeature" VARCHAR;
ALTER TABLE "osmm_topo"."cartographicsymbol" ADD COLUMN "filename" VARCHAR;

DROP TABLE IF EXISTS "osmm_topo"."cartographictext" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'cartographictext' AND f_table_schema = 'osmm_topo';

CREATE TABLE "osmm_topo"."cartographictext" ( OGC_FID SERIAL, CONSTRAINT "cartographictext_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('osmm_topo','cartographictext','wkb_geometry',27700,'POINT',2);
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "theme" VARCHAR[];
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "changedate" VARCHAR[];
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "reasonforchange" VARCHAR[];
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "descriptivegroup" VARCHAR[];
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "descriptiveterm" VARCHAR[];
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "make" VARCHAR;
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "physicallevel" INTEGER;
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "physicalpresence" VARCHAR;
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "anchorposition" INTEGER;
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "font" INTEGER;
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "height" FLOAT8;
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "orientation" INTEGER;
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "textstring" VARCHAR;
ALTER TABLE "osmm_topo"."cartographictext" ADD COLUMN "filename" VARCHAR;

DROP TABLE IF EXISTS "osmm_topo"."topographicarea" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'topographicarea' AND f_table_schema = 'osmm_topo';

CREATE TABLE "osmm_topo"."topographicarea" ( OGC_FID SERIAL, CONSTRAINT "topographicarea_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('osmm_topo','topographicarea','wkb_geometry',27700,'POLYGON',2);
ALTER TABLE "osmm_topo"."topographicarea" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_topo"."topographicarea" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "osmm_topo"."topographicarea" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_topo"."topographicarea" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_topo"."topographicarea" ADD COLUMN "theme" VARCHAR[];
ALTER TABLE "osmm_topo"."topographicarea" ADD COLUMN "calculatedareavalue" FLOAT8;
ALTER TABLE "osmm_topo"."topographicarea" ADD COLUMN "changedate" VARCHAR[];
ALTER TABLE "osmm_topo"."topographicarea" ADD COLUMN "reasonforchange" VARCHAR[];
ALTER TABLE "osmm_topo"."topographicarea" ADD COLUMN "descriptivegroup" VARCHAR[];
ALTER TABLE "osmm_topo"."topographicarea" ADD COLUMN "descriptiveterm" VARCHAR[];
ALTER TABLE "osmm_topo"."topographicarea" ADD COLUMN "make" VARCHAR;
ALTER TABLE "osmm_topo"."topographicarea" ADD COLUMN "physicallevel" INTEGER;
ALTER TABLE "osmm_topo"."topographicarea" ADD COLUMN "physicalpresence" VARCHAR;
ALTER TABLE "osmm_topo"."topographicarea" ADD COLUMN "filename" VARCHAR;

DROP TABLE IF EXISTS "osmm_topo"."topographicline" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'topographicline' AND f_table_schema = 'osmm_topo';

CREATE TABLE "osmm_topo"."topographicline" ( OGC_FID SERIAL, CONSTRAINT "topographicline_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('osmm_topo','topographicline','wkb_geometry',27700,'MULTILINESTRING',2);
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "theme" VARCHAR[];
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "accuracyofposition" VARCHAR;
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "changedate" VARCHAR[];
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "reasonforchange" VARCHAR[];
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "descriptivegroup" VARCHAR[];
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "descriptiveterm" VARCHAR[];
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "nonboundingline" VARCHAR;
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "heightabovedatum" FLOAT8;
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "accuracyofheightabovedatum" VARCHAR;
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "heightabovegroundlevel" FLOAT8;
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "accuracyofheightabovegroundlevel" VARCHAR;
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "make" VARCHAR;
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "physicallevel" INTEGER;
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "physicalpresence" VARCHAR;
ALTER TABLE "osmm_topo"."topographicline" ADD COLUMN "filename" VARCHAR;

DROP TABLE IF EXISTS "osmm_topo"."topographicpoint" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'topographicpoint' AND f_table_schema = 'osmm_topo';

CREATE TABLE "osmm_topo"."topographicpoint" ( OGC_FID SERIAL, CONSTRAINT "topographicpoint_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('osmm_topo','topographicpoint','wkb_geometry',27700,'POINT',2);
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "theme" VARCHAR[];
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "accuracyofposition" VARCHAR;
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "changedate" VARCHAR[];
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "reasonforchange" VARCHAR[];
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "descriptivegroup" VARCHAR[];
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "descriptiveterm" VARCHAR[];
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "heightabovedatum" FLOAT8;
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "accuracyofheightabovedatum" VARCHAR;
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "make" VARCHAR;
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "physicallevel" INTEGER;
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "physicalpresence" VARCHAR;
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "referencetofeature" VARCHAR;
ALTER TABLE "osmm_topo"."topographicpoint" ADD COLUMN "filename" VARCHAR;
