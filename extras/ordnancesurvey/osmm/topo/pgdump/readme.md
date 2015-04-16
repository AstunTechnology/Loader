# Loading Postgres using the PGDump driver

Tests have found that using the [PGDump OGR](http://www.gdal.org/ogr/drv_pgdump.html) driver to create SQL dump files that are then loaded into Postgres using psql can be significantly faster than using the standard [Postgres driver](http://www.gdal.org/ogr/drv_pg.html). Using the PGDump driver introduces some additional steps to the process but the extra effort are probably worthwhile if you are loading a reasonable amount of data (more than 100 files).

The process goes like this:

* Create the required Postgres schema and tables as demonstrated in create-tables.sql (you may need to alter the SQL to match your setup).
* Run the loader to create SQL dump files in a given directory. The sample loader.config in this directory includes an example ogr2ogr command using the PGDump driver and COPY statements in place of INSERT for speed.
* Create a spatial index for each table as demonstrated in create-indexes.sql

## Example shell script

    # Assumes current directory is the root of the repository

    # (Re)create the tables in Postgres
    psql -U postgres -d postgis -f extras/ordnancesurvey/osmm/topo/pgdump/create-tables.sql

    # Run Loader from the python directory using the OSMM Topo PGDump config
    (cd python && python loader.py ../extras/ordnancesurvey/osmm/topo/pgdump/loader.config)

    # Create spatial indexes
    psql -U postgres -d postgis -f extras/ordnancesurvey/osmm/topo/pgdump/create-indexes.sql

## Dependencies ##

* OGR 1.9
    * OGR 1.9 is recommended to avoid the known issue with OGR 1.8 related to loading single features into a geometry column of type MULTI
