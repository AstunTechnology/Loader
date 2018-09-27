-- Loader. Copyright (c) Astun Technology Ltd. (http://astuntechnology.com).
-- Licensed under [MIT License](https://git.io/fAxH0).

-- Create tables suitable for loading a VML update. Drops any existing VML
-- update tables. Assumes there is a schema called vml_update. The ogc_fid
-- column is dropped to avoid issues with inserting into the main tables as
-- ogc_fid is an auto generated SERIAL. It is expected that this script is ran
-- prior to an update being loaded.

DROP TABLE IF EXISTS vml_update.text CASCADE;
CREATE TABLE vml_update.text (LIKE vml.text);
ALTER TABLE vml_update.text DROP COLUMN ogc_fid;

DROP TABLE IF EXISTS vml_update.vectormappoint CASCADE;
CREATE TABLE vml_update.vectormappoint (LIKE vml.vectormappoint);
ALTER TABLE vml_update.vectormappoint DROP COLUMN ogc_fid;

DROP TABLE IF EXISTS vml_update.line CASCADE;
CREATE TABLE vml_update.line (LIKE vml.line);
ALTER TABLE vml_update.line DROP COLUMN ogc_fid;

DROP TABLE IF EXISTS vml_update.roadcline CASCADE;
CREATE TABLE vml_update.roadcline (LIKE vml.roadcline);
ALTER TABLE vml_update.roadcline DROP COLUMN ogc_fid;

DROP TABLE IF EXISTS vml_update.area CASCADE;
CREATE TABLE vml_update.area (LIKE vml.area);
ALTER TABLE vml_update.area DROP COLUMN ogc_fid;
