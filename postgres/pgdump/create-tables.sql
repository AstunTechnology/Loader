-- Drops any existing OSMM related tables and creates fresh tables ready to receive data

DROP TABLE IF EXISTS "osmm"."boundaryline" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'boundaryline' AND f_table_schema = 'osmm';

CREATE TABLE "osmm"."boundaryline" ( OGC_FID SERIAL, CONSTRAINT "boundaryline_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('osmm','boundaryline','wkb_geometry',27700,'GEOMETRY',2);
ALTER TABLE "osmm"."boundaryline" ADD COLUMN "fid" CHAR(20);
ALTER TABLE "osmm"."boundaryline" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "osmm"."boundaryline" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm"."boundaryline" ADD COLUMN "versiondate" CHAR(10);
ALTER TABLE "osmm"."boundaryline" ADD COLUMN "theme" CHAR(25);
ALTER TABLE "osmm"."boundaryline" ADD COLUMN "accuracyofposition" CHAR(4);
ALTER TABLE "osmm"."boundaryline" ADD COLUMN "changedate" varchar[];
ALTER TABLE "osmm"."boundaryline" ADD COLUMN "reasonforchange" varchar[];
ALTER TABLE "osmm"."boundaryline" ADD COLUMN "descriptivegroup" CHAR(27);
ALTER TABLE "osmm"."boundaryline" ADD COLUMN "descriptiveterm" CHAR(13);
ALTER TABLE "osmm"."boundaryline" ADD COLUMN "physicallevel" INTEGER;
ALTER TABLE "osmm"."boundaryline" ADD COLUMN "physicalpresence" CHAR(8);

DROP TABLE IF EXISTS "osmm"."cartographicsymbol" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'cartographicsymbol' AND f_table_schema = 'osmm';

CREATE TABLE "osmm"."cartographicsymbol" ( OGC_FID SERIAL, CONSTRAINT "cartographicsymbol_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('osmm','cartographicsymbol','wkb_geometry',27700,'POINT',2);
ALTER TABLE "osmm"."cartographicsymbol" ADD COLUMN "fid" CHAR(20);
ALTER TABLE "osmm"."cartographicsymbol" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "osmm"."cartographicsymbol" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm"."cartographicsymbol" ADD COLUMN "versiondate" CHAR(10);
ALTER TABLE "osmm"."cartographicsymbol" ADD COLUMN "theme" CHAR(25);
ALTER TABLE "osmm"."cartographicsymbol" ADD COLUMN "changedate" varchar[];
ALTER TABLE "osmm"."cartographicsymbol" ADD COLUMN "reasonforchange" varchar[];
ALTER TABLE "osmm"."cartographicsymbol" ADD COLUMN "descriptivegroup" CHAR(27);
ALTER TABLE "osmm"."cartographicsymbol" ADD COLUMN "descriptiveterm" CHAR(21);
ALTER TABLE "osmm"."cartographicsymbol" ADD COLUMN "orientation" INTEGER;
ALTER TABLE "osmm"."cartographicsymbol" ADD COLUMN "physicallevel" INTEGER;
ALTER TABLE "osmm"."cartographicsymbol" ADD COLUMN "referencetofeature" VARCHAR;
ALTER TABLE "osmm"."cartographicsymbol" ADD COLUMN "physicalpresence" CHAR(9);

DROP TABLE IF EXISTS "osmm"."cartographictext" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'cartographictext' AND f_table_schema = 'osmm';

CREATE TABLE "osmm"."cartographictext" ( OGC_FID SERIAL, CONSTRAINT "cartographictext_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('osmm','cartographictext','wkb_geometry',27700,'POINT',2);
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "fid" CHAR(20);
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "versiondate" CHAR(10);
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "theme" CHAR(25);
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "changedate" varchar[];
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "reasonforchange" varchar[];
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "descriptivegroup" CHAR(27);
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "physicallevel" INTEGER;
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "anchorposition" INTEGER;
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "font" INTEGER;
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "height" FLOAT8;
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "orientation" INTEGER;
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "textstring" CHAR(25);
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "make" CHAR(8);
ALTER TABLE "osmm"."cartographictext" ADD COLUMN "descriptiveterm" CHAR(27);

DROP TABLE IF EXISTS "osmm"."topographicarea" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'topographicarea' AND f_table_schema = 'osmm';

CREATE TABLE "osmm"."topographicarea" ( OGC_FID SERIAL, CONSTRAINT "topographicarea_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('osmm','topographicarea','wkb_geometry',27700,'POLYGON',2);
ALTER TABLE "osmm"."topographicarea" ADD COLUMN "fid" CHAR(20);
ALTER TABLE "osmm"."topographicarea" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "osmm"."topographicarea" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm"."topographicarea" ADD COLUMN "versiondate" CHAR(10);
ALTER TABLE "osmm"."topographicarea" ADD COLUMN "theme" varchar[];
ALTER TABLE "osmm"."topographicarea" ADD COLUMN "calculatedareavalue" FLOAT8;
ALTER TABLE "osmm"."topographicarea" ADD COLUMN "changedate" varchar[];
ALTER TABLE "osmm"."topographicarea" ADD COLUMN "reasonforchange" varchar[];
ALTER TABLE "osmm"."topographicarea" ADD COLUMN "descriptivegroup" varchar[];
ALTER TABLE "osmm"."topographicarea" ADD COLUMN "descriptiveterm" varchar[];
ALTER TABLE "osmm"."topographicarea" ADD COLUMN "make" CHAR(8);
ALTER TABLE "osmm"."topographicarea" ADD COLUMN "physicallevel" INTEGER;

DROP TABLE IF EXISTS "osmm"."topographicline" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'topographicline' AND f_table_schema = 'osmm';

CREATE TABLE "osmm"."topographicline" ( OGC_FID SERIAL, CONSTRAINT "topographicline_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('osmm','topographicline','wkb_geometry',27700,'LINESTRING',2);
ALTER TABLE "osmm"."topographicline" ADD COLUMN "fid" CHAR(20);
ALTER TABLE "osmm"."topographicline" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "osmm"."topographicline" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm"."topographicline" ADD COLUMN "versiondate" CHAR(10);
ALTER TABLE "osmm"."topographicline" ADD COLUMN "theme" varchar[];
ALTER TABLE "osmm"."topographicline" ADD COLUMN "accuracyofposition" CHAR(7);
ALTER TABLE "osmm"."topographicline" ADD COLUMN "changedate" varchar[];
ALTER TABLE "osmm"."topographicline" ADD COLUMN "reasonforchange" varchar[];
ALTER TABLE "osmm"."topographicline" ADD COLUMN "descriptivegroup" varchar[];
ALTER TABLE "osmm"."topographicline" ADD COLUMN "physicallevel" INTEGER;
ALTER TABLE "osmm"."topographicline" ADD COLUMN "physicalpresence" CHAR(12);
ALTER TABLE "osmm"."topographicline" ADD COLUMN "make" CHAR(7);
ALTER TABLE "osmm"."topographicline" ADD COLUMN "nonboundingline" CHAR(4);
ALTER TABLE "osmm"."topographicline" ADD COLUMN "descriptiveterm" CHAR(30);

DROP TABLE IF EXISTS "osmm"."topographicpoint" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'topographicpoint' AND f_table_schema = 'osmm';

CREATE TABLE "osmm"."topographicpoint" ( OGC_FID SERIAL, CONSTRAINT "topographicpoint_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('osmm','topographicpoint','wkb_geometry',27700,'POINT',2);
ALTER TABLE "osmm"."topographicpoint" ADD COLUMN "fid" CHAR(20);
ALTER TABLE "osmm"."topographicpoint" ADD COLUMN "featurecode" INTEGER;
ALTER TABLE "osmm"."topographicpoint" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm"."topographicpoint" ADD COLUMN "versiondate" CHAR(10);
ALTER TABLE "osmm"."topographicpoint" ADD COLUMN "theme" varchar[];
ALTER TABLE "osmm"."topographicpoint" ADD COLUMN "accuracyofposition" CHAR(4);
ALTER TABLE "osmm"."topographicpoint" ADD COLUMN "changedate" varchar[];
ALTER TABLE "osmm"."topographicpoint" ADD COLUMN "reasonforchange" varchar[];
ALTER TABLE "osmm"."topographicpoint" ADD COLUMN "descriptivegroup" varchar[];
ALTER TABLE "osmm"."topographicpoint" ADD COLUMN "descriptiveterm" CHAR(29);
ALTER TABLE "osmm"."topographicpoint" ADD COLUMN "make" CHAR(7);
ALTER TABLE "osmm"."topographicpoint" ADD COLUMN "physicallevel" INTEGER;
ALTER TABLE "osmm"."topographicpoint" ADD COLUMN "heightabovedatum" FLOAT8;
ALTER TABLE "osmm"."topographicpoint" ADD COLUMN "accuracyofheightabovedatum" CHAR(4);
