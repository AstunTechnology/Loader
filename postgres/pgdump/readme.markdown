# Loading Postgres using the PGDump driver #

Tests have found that using the [PGDump OGR](http://www.gdal.org/ogr/drv_pgdump.html) driver to create SQL dump files that are then loaded into Postgres using psql can be significantly faster than using the standard [Postgres driver](http://www.gdal.org/ogr/drv_pg.html). Using the PGDump driver introduces some additional steps to the process but the extra effort are probably worthwhile if you are loading a reasonable amount of data (more than 100 files).

The process goes like this:

* Create the required Postgres schema and tables as demonstrated in create-tables.sql (you may need to alter the SQL to match your setup).
* Run the loader to create SQL dump files in a given directory. The sample osmmloader.config in this directory includes an example ogr2ogr command using the PGDump driver and COPY statements in place of INSERT for speed.
* Load the SQL dump files into the Postgres database using the psql utility provided by Postgres
* Create a spatial index for each table as demonstrated in create-indexes.sql

A bash shell script might look like this:

```
# Assumes current directory is osmmloader/postgres/pgdump

# (Re)create the tables in Postgres
psql -d mapbase -U postgres -f create-tables.sql

export GDAL_DATA=/usr/share/gdal/1.8

# Run the OSMM loader
cd ../../python
python osmmloader.py ../postgres/pgdump/osmmloader.config

# Load the SQL files via psql. Assumes the user running this script can
# provide credentials for the user running the SQL
for f in /var/tmp/osmm/*.sql; do psql -d mapbase -U postgres -f "$f"; done

cd ../postgres/pgdump

# Create spatial indexes
psql -d mapbase -U postgres -f create-indexes.sql
```

## Dependencies ##

* OGR 1.8.1
  * If you want to avoid (no fatal) error messages when loading the SQL dump files then you need GDAL >= 1.8.1 in order to use the create_schema layer creation option (-lco create_schema=off).
