-- Loader. Copyright (c) Astun Technology Ltd. (http://astuntechnology.com).
-- Licensed under [MIT License](https://git.io/fAxH0).

-- Drops any existing OSMM ITN tables and creates fresh tables ready to receive data

-- NOTE: The roadnodeinformation, roadlinkinformation and roadrouteinformation
-- tables all define a datetimequalifier column of type JSON. The JSON data
-- type was introduced in PostgreSQL 9.2, if you are loading into an earlier
-- version of PostgreSQL you will need to update the column type to be TEXT.

DROP TABLE IF EXISTS "osmm_itn"."road" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'road' AND f_table_schema = 'osmm_itn';

CREATE TABLE "osmm_itn"."road" (OGC_FID SERIAL, CONSTRAINT "road_pk" PRIMARY KEY (OGC_FID));
ALTER TABLE "osmm_itn"."road" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_itn"."road" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_itn"."road" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_itn"."road" ADD COLUMN "changedate" varchar[];
ALTER TABLE "osmm_itn"."road" ADD COLUMN "reasonforchange" varchar[];
ALTER TABLE "osmm_itn"."road" ADD COLUMN "descriptivegroup" VARCHAR;
ALTER TABLE "osmm_itn"."road" ADD COLUMN "descriptiveterm" VARCHAR;
ALTER TABLE "osmm_itn"."road" ADD COLUMN "roadname" varchar[];
ALTER TABLE "osmm_itn"."road" ADD COLUMN "networkmember_href" varchar[];
ALTER TABLE "osmm_itn"."road" ADD COLUMN "theme" VARCHAR;
ALTER TABLE "osmm_itn"."road" ADD COLUMN "filename" VARCHAR;

DROP TABLE IF EXISTS "osmm_itn"."roadlink" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'roadlink' AND f_table_schema = 'osmm_itn';

CREATE TABLE "osmm_itn"."roadlink" (OGC_FID SERIAL, CONSTRAINT "roadlink_pk" PRIMARY KEY (OGC_FID));
SELECT AddGeometryColumn('osmm_itn','roadlink','wkb_geometry',27700,'LINESTRING',2);
ALTER TABLE "osmm_itn"."roadlink" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_itn"."roadlink" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_itn"."roadlink" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_itn"."roadlink" ADD COLUMN "changedate" varchar[];
ALTER TABLE "osmm_itn"."roadlink" ADD COLUMN "reasonforchange" varchar[];
ALTER TABLE "osmm_itn"."roadlink" ADD COLUMN "descriptivegroup" VARCHAR;
ALTER TABLE "osmm_itn"."roadlink" ADD COLUMN "descriptiveterm" VARCHAR;
ALTER TABLE "osmm_itn"."roadlink" ADD COLUMN "natureofroad" VARCHAR;
ALTER TABLE "osmm_itn"."roadlink" ADD COLUMN "length" FLOAT8;
ALTER TABLE "osmm_itn"."roadlink" ADD COLUMN "directednode_href" varchar[];
ALTER TABLE "osmm_itn"."roadlink" ADD COLUMN "directednode_orientation" varchar[];
ALTER TABLE "osmm_itn"."roadlink" ADD COLUMN "directednode_gradeseparation" INTEGER[];
ALTER TABLE "osmm_itn"."roadlink" ADD COLUMN "referencetotopographicarea_href" varchar[];
ALTER TABLE "osmm_itn"."roadlink" ADD COLUMN "theme" VARCHAR;
ALTER TABLE "osmm_itn"."roadlink" ADD COLUMN "filename" VARCHAR;

DROP TABLE IF EXISTS "osmm_itn"."roadnode" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'roadnode' AND f_table_schema = 'osmm_itn';

CREATE TABLE "osmm_itn"."roadnode" ( OGC_FID SERIAL, CONSTRAINT "roadnode_pk" PRIMARY KEY (OGC_FID));
SELECT AddGeometryColumn('osmm_itn','roadnode','wkb_geometry',27700,'POINT',2);
ALTER TABLE "osmm_itn"."roadnode" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_itn"."roadnode" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_itn"."roadnode" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_itn"."roadnode" ADD COLUMN "changedate" varchar[];
ALTER TABLE "osmm_itn"."roadnode" ADD COLUMN "reasonforchange" varchar[];
ALTER TABLE "osmm_itn"."roadnode" ADD COLUMN "descriptivegroup" VARCHAR;
ALTER TABLE "osmm_itn"."roadnode" ADD COLUMN "referencetotopographicarea_href" VARCHAR;
ALTER TABLE "osmm_itn"."roadnode" ADD COLUMN "theme" VARCHAR;
ALTER TABLE "osmm_itn"."roadnode" ADD COLUMN "filename" VARCHAR;

DROP TABLE IF EXISTS "osmm_itn"."ferrylink" CASCADE;

CREATE TABLE "osmm_itn"."ferrylink" (OGC_FID SERIAL, CONSTRAINT "ferrylink_pk" PRIMARY KEY (OGC_FID));
ALTER TABLE "osmm_itn"."ferrylink" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_itn"."ferrylink" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_itn"."ferrylink" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_itn"."ferrylink" ADD COLUMN "changedate" varchar[];
ALTER TABLE "osmm_itn"."ferrylink" ADD COLUMN "reasonforchange" varchar[];
ALTER TABLE "osmm_itn"."ferrylink" ADD COLUMN "descriptivegroup" VARCHAR;
ALTER TABLE "osmm_itn"."ferrylink" ADD COLUMN "directednode_href" varchar[];
ALTER TABLE "osmm_itn"."ferrylink" ADD COLUMN "directednode_orientation" varchar[];
ALTER TABLE "osmm_itn"."ferrylink" ADD COLUMN "theme" VARCHAR;
ALTER TABLE "osmm_itn"."ferrylink" ADD COLUMN "filename" VARCHAR;

DROP TABLE IF EXISTS "osmm_itn"."ferrynode" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'ferrynode' AND f_table_schema = 'osmm_itn';

CREATE TABLE "osmm_itn"."ferrynode" (OGC_FID SERIAL, CONSTRAINT "ferrynode_pk" PRIMARY KEY (OGC_FID));
SELECT AddGeometryColumn('osmm_itn','ferrynode','wkb_geometry',27700,'POINT',2);
ALTER TABLE "osmm_itn"."ferrynode" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_itn"."ferrynode" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_itn"."ferrynode" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_itn"."ferrynode" ADD COLUMN "changedate" varchar[];
ALTER TABLE "osmm_itn"."ferrynode" ADD COLUMN "reasonforchange" varchar[];
ALTER TABLE "osmm_itn"."ferrynode" ADD COLUMN "descriptivegroup" VARCHAR;
ALTER TABLE "osmm_itn"."ferrynode" ADD COLUMN "theme" VARCHAR;
ALTER TABLE "osmm_itn"."ferrynode" ADD COLUMN "filename" VARCHAR;

DROP TABLE IF EXISTS "osmm_itn"."ferryterminal" CASCADE;

CREATE TABLE "osmm_itn"."ferryterminal" (OGC_FID SERIAL, CONSTRAINT "ferryterminal_pk" PRIMARY KEY (OGC_FID));
ALTER TABLE "osmm_itn"."ferryterminal" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_itn"."ferryterminal" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_itn"."ferryterminal" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_itn"."ferryterminal" ADD COLUMN "changedate" varchar[];
ALTER TABLE "osmm_itn"."ferryterminal" ADD COLUMN "reasonforchange" varchar[];
ALTER TABLE "osmm_itn"."ferryterminal" ADD COLUMN "descriptivegroup" VARCHAR;
ALTER TABLE "osmm_itn"."ferryterminal" ADD COLUMN "descriptiveterm" varchar[];
ALTER TABLE "osmm_itn"."ferryterminal" ADD COLUMN "referencetonetwork_href" varchar[];
ALTER TABLE "osmm_itn"."ferryterminal" ADD COLUMN "theme" VARCHAR;
ALTER TABLE "osmm_itn"."ferryterminal" ADD COLUMN "filename" VARCHAR;

DROP TABLE IF EXISTS "osmm_itn"."informationpoint" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'informationpoint' AND f_table_schema = 'osmm_itn';

CREATE TABLE "osmm_itn"."informationpoint" (OGC_FID SERIAL, CONSTRAINT "informationpoint_pk" PRIMARY KEY (OGC_FID));
SELECT AddGeometryColumn('osmm_itn','informationpoint','wkb_geometry',27700,'POINT',2);
ALTER TABLE "osmm_itn"."informationpoint" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_itn"."informationpoint" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_itn"."informationpoint" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_itn"."informationpoint" ADD COLUMN "changedate" varchar[];
ALTER TABLE "osmm_itn"."informationpoint" ADD COLUMN "reasonforchange" varchar[];
ALTER TABLE "osmm_itn"."informationpoint" ADD COLUMN "descriptivegroup" VARCHAR;
ALTER TABLE "osmm_itn"."informationpoint" ADD COLUMN "junctionname" VARCHAR;
ALTER TABLE "osmm_itn"."informationpoint" ADD COLUMN "theme" VARCHAR;
ALTER TABLE "osmm_itn"."informationpoint" ADD COLUMN "filename" VARCHAR;

DROP TABLE IF EXISTS "osmm_itn"."roadnodeinformation" CASCADE;

CREATE TABLE "osmm_itn"."roadnodeinformation" (OGC_FID SERIAL, CONSTRAINT "roadnodeinformation_pk" PRIMARY KEY (OGC_FID));
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "changedate" VARCHAR;
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "reasonforchange" VARCHAR;
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "descriptivegroup" VARCHAR;
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "referencetoroadnode_href" VARCHAR;
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "referencetoroadnode_gradeseparation" INTEGER;
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "datetimequalifier" json;
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "vehiclequalifier_type" varchar[];
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "vehiclequalifier_type_exceptfor" varchar[];
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "vehiclequalifier_use" varchar[];
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "vehiclequalifier_use_exceptfor" varchar[];
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "vehiclequalifier_maxheight" FLOAT8[];
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "vehiclequalifier_maxcompositeheight_feet" FLOAT8[];
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "vehiclequalifier_maxcompositeheight_inches" FLOAT8[];
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "environmentqualifier_classification" varchar[];
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "environmentqualifier_instruction" varchar[];
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "theme" VARCHAR;
ALTER TABLE "osmm_itn"."roadnodeinformation" ADD COLUMN "filename" VARCHAR;

DROP TABLE IF EXISTS "osmm_itn"."roadlinkinformation" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'roadlinkinformation' AND f_table_schema = 'osmm_itn';

CREATE TABLE "osmm_itn"."roadlinkinformation" (OGC_FID SERIAL, CONSTRAINT "roadlinkinformation_pk" PRIMARY KEY (OGC_FID));
SELECT AddGeometryColumn('osmm_itn','roadlinkinformation','wkb_geometry',27700,'POINT',2);
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "changedate" varchar[];
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "reasonforchange" varchar[];
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "descriptivegroup" VARCHAR;
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "referencetoroadlink_href" VARCHAR;
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "datetimequalifier" json;
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "vehiclequalifier_type" varchar[];
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "vehiclequalifier_type_exceptfor" varchar[];
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "vehiclequalifier_use" varchar[];
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "vehiclequalifier_use_exceptfor" varchar[];
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "vehiclequalifier_maxheight" FLOAT8[];
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "vehiclequalifier_maxcompositeheight_feet" FLOAT8[];
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "vehiclequalifier_maxcompositeheight_inches" FLOAT8[];
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "environmentqualifier_classification" varchar[];
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "environmentqualifier_instruction" varchar[];
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "distancefromstart" FLOAT8;
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "theme" VARCHAR;
ALTER TABLE "osmm_itn"."roadlinkinformation" ADD COLUMN "filename" VARCHAR;

DROP TABLE IF EXISTS "osmm_itn"."roadrouteinformation" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'roadrouteinformation' AND f_table_schema = 'osmm_itn';

CREATE TABLE "osmm_itn"."roadrouteinformation" (OGC_FID SERIAL, CONSTRAINT "roadrouteinformation_pk" PRIMARY KEY (OGC_FID));
SELECT AddGeometryColumn('osmm_itn','roadrouteinformation','wkb_geometry',27700,'POINT',2);
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "fid" VARCHAR;
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "version" INTEGER;
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "versiondate" VARCHAR;
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "changedate" varchar[];
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "reasonforchange" varchar[];
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "descriptivegroup" VARCHAR;
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "directedlink_href" varchar[];
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "directedlink_orientation" varchar[];
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "datetimequalifier" json;
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "vehiclequalifier_type" varchar[];
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "vehiclequalifier_type_exceptfor" varchar[];
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "vehiclequalifier_use" varchar[];
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "vehiclequalifier_use_exceptfor" varchar[];
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "vehiclequalifier_maxheight" FLOAT8[];
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "vehiclequalifier_maxcompositeheight_feet" FLOAT8[];
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "vehiclequalifier_maxcompositeheight_inches" FLOAT8[];
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "environmentqualifier_classification" varchar[];
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "environmentqualifier_instruction" varchar[];
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "distancefromstart" FLOAT8;
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "theme" VARCHAR;
ALTER TABLE "osmm_itn"."roadrouteinformation" ADD COLUMN "filename" VARCHAR;

