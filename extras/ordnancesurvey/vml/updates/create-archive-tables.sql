-- Create tables suitable for archiving superseded VML features. Assumes there
-- is a schema called vml_archive. It's expected that this script is ran once
-- following an initial load. The script apply-update.sql manages moving
-- superseded features to the archive tables.

CREATE TABLE vml_archive.area AS SELECT * FROM vml.area WHERE ogc_fid = -1;
CREATE TABLE vml_archive.line AS SELECT * FROM vml.line WHERE ogc_fid = -1;
CREATE TABLE vml_archive.roadcline AS SELECT * FROM vml.roadcline WHERE ogc_fid = -1;
CREATE TABLE vml_archive.text AS SELECT * FROM vml.text WHERE ogc_fid = -1;
CREATE TABLE vml_archive.vectormappoint AS SELECT * FROM vml.vectormappoint WHERE ogc_fid = -1;
