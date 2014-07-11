-- Create tables suitable for archiving superseded VML features. Assumes there
-- is a schema called vml_archive. The script apply-update.sql manages moving
-- superseded features to the archive tables.

CREATE TABLE IF NOT EXISTS vml_archive.text (LIKE vml.text);
CREATE TABLE IF NOT EXISTS vml_archive.vectormappoint (LIKE vml.vectormappoint);
CREATE TABLE IF NOT EXISTS vml_archive.line (LIKE vml.line);
CREATE TABLE IF NOT EXISTS vml_archive.roadcline (LIKE vml.roadcline);
CREATE TABLE IF NOT EXISTS vml_archive.area (LIKE vml.area);
