# Loading OS AddressBase Premium using PGDump driver

Using the [PGDump OGR](http://www.gdal.org/ogr/drv_pgdump.html) ogr driver generally is much quicker than the [Postgres driver](http://www.gdal.org/ogr/drv_pg.html) but requires more set-up.

The files in this directory are provided to help you get started, you should update the schema name in sql files and paths, connection details etc. in loader.config to suit your environment.

## Example shell script

    # Assumes current directory is the root of the repository

    # (Re)create the tables in Postgres
    psql -d postgis -U postgres -f extras/ordnancesurvey/addressbase/premium/pgdump/create-tables.sql

    # Run the OSMM loader from the python directory using the AddressBase
    # Premium PGDump config in this directory
    (cd python && python loader.py ../extras/ordnancesurvey/addressbase/premium/pgdump/loader.config)

    # Create spatial indexes
    psql -d postgis -U postgres -f extras/ordnancesurvey/addressbase/premium/pgdump/create-indexes.sql
