-- Create tables suitable for loading a VML update. Drops any existing VML
-- update tables. Assumes there is a schema called vml_update. It is expected
-- that this script is ran prior to an update being loaded.

DROP TABLE IF EXISTS "vml_update"."text" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'text' AND f_table_schema = 'vml_update';
CREATE TABLE vml_update.text
(
  fid character varying,
  featurecode integer,
  featuredescription character varying,
  anchorposition integer,
  font integer,
  height double precision,
  orientation integer,
  orientdeg double precision,
  textstring character varying,
  tile character varying,
  creationdate date
);
SELECT AddGeometryColumn('vml_update','text','wkb_geometry',27700,'POINT',2);

DROP TABLE IF EXISTS "vml_update"."vectormappoint" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'vectormappoint' AND f_table_schema = 'vml_update';
CREATE TABLE vml_update.vectormappoint
(
  fid character varying,
  featurecode integer,
  featuredescription character varying,
  orientation integer,
  orientdeg double precision,
  tile character varying,
  creationdate date
);
SELECT AddGeometryColumn('vml_update','vectormappoint','wkb_geometry',27700,'POINT',2);

DROP TABLE IF EXISTS "vml_update"."line" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'line' AND f_table_schema = 'vml_update';
CREATE TABLE vml_update.line
(
  fid character varying,
  featurecode integer,
  featuredescription character varying,
  tile character varying,
  creationdate date
);
SELECT AddGeometryColumn('vml_update','line','wkb_geometry',27700,'LINESTRING',2);

DROP TABLE IF EXISTS "vml_update"."roadcline" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'roadcline' AND f_table_schema = 'vml_update';
CREATE TABLE vml_update.roadcline
(
  fid character varying,
  featurecode integer,
  featuredescription character varying,
  roadnumber character varying,
  roadname character varying,
  tile character varying,
  creationdate date
);
SELECT AddGeometryColumn('vml_update','roadcline','wkb_geometry',27700,'LINESTRING',2);

DROP TABLE IF EXISTS "vml_update"."area" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'area' AND f_table_schema = 'vml_update';
CREATE TABLE vml_update.area
(
  fid character varying,
  featurecode integer,
  featuredescription character varying,
  tile character varying,
  creationdate date
);
SELECT AddGeometryColumn('vml_update','area','wkb_geometry',27700,'POLYGON',2);
