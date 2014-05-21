BEGIN;

-- Delete rows in current table (vml schema) that belong to a tile for which
-- features are present in the update table (vml_update schema); Insert
-- superseded rows from the current table to archive table (vml_archive schema)
-- providing they do not already exist in the archive
WITH superseded AS (DELETE FROM vml.text WHERE tile IN (SELECT DISTINCT tile FROM vml_update.text) RETURNING *)
INSERT INTO vml_archive.text SELECT * FROM superseded s WHERE NOT EXISTS (SELECT 1 FROM vml_archive.text a WHERE s.tile = a.tile and s.creationdate = a.creationdate);

-- Delete rows from update table and insert into current table taking care to
-- match the column order in the update table and omitting the ogc_fid column
-- which is a auto generated SERIAL
WITH fresh AS (DELETE FROM vml_update.text RETURNING *)
INSERT INTO vml.text (fid, featurecode, featuredescription, anchorposition, font, height, orientation, orientdeg, textstring, tile, creationdate, wkb_geometry) SELECT * FROM fresh;

WITH superseded AS (DELETE FROM vml.vectormappoint WHERE tile IN (SELECT DISTINCT tile FROM vml_update.vectormappoint) RETURNING *)
INSERT INTO vml_archive.vectormappoint SELECT * FROM superseded s WHERE NOT EXISTS (SELECT 1 FROM vml_archive.vectormappoint a WHERE s.tile = a.tile and s.creationdate = a.creationdate);
WITH fresh AS (DELETE FROM vml_update.vectormappoint RETURNING *)
INSERT INTO vml.vectormappoint (fid, featurecode, featuredescription, orientation, orientdeg, tile, creationdate, wkb_geometry) SELECT * FROM fresh;

WITH superseded AS (DELETE FROM vml.line WHERE tile IN (SELECT DISTINCT tile FROM vml_update.line) RETURNING *)
INSERT INTO vml_archive.line SELECT * FROM superseded s WHERE NOT EXISTS (SELECT 1 FROM vml_archive.line a WHERE s.tile = a.tile and s.creationdate = a.creationdate);
WITH fresh AS (DELETE FROM vml_update.line RETURNING *)
INSERT INTO vml.line (fid, featurecode, featuredescription, tile, creationdate, wkb_geometry) SELECT * FROM fresh;

WITH superseded AS (DELETE FROM vml.roadcline WHERE tile IN (SELECT DISTINCT tile FROM vml_update.roadcline) RETURNING *)
INSERT INTO vml_archive.roadcline SELECT * FROM superseded s WHERE NOT EXISTS (SELECT 1 FROM vml_archive.roadcline a WHERE s.tile = a.tile and s.creationdate = a.creationdate);
WITH fresh AS (DELETE FROM vml_update.roadcline RETURNING *)
INSERT INTO vml.roadcline (fid, featurecode, featuredescription, roadnumber, roadname, tile, creationdate, wkb_geometry) SELECT * FROM fresh;

WITH superseded AS (DELETE FROM vml.area WHERE tile IN (SELECT DISTINCT tile FROM vml_update.area) RETURNING *)
INSERT INTO vml_archive.area SELECT * FROM superseded s WHERE NOT EXISTS (SELECT 1 FROM vml_archive.area a WHERE s.tile = a.tile and s.creationdate = a.creationdate);
WITH fresh AS (DELETE FROM vml_update.area RETURNING *)
INSERT INTO vml.area (fid, featurecode, featuredescription, tile, creationdate, wkb_geometry) SELECT * FROM fresh;

COMMIT;
