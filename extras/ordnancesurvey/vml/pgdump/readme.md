# Loading VML into Postgres using the PGDump driver #

Generally you want to use the OGR `PGDump` driver to load into Postgres if you are loading a significant number of files as it's much quicker than the standard `PostgreSQL` driver. See the [OSMM Topo readme](../../osmm/topo/pgdump/readme.markdown) for more background.

## Assumptions

The example SQL and configuration provided assume loading into a database called `postgis` and a schema called `vml`, you many need to edit these files to match your enviroment.

## Usage

A bash shell script to coordinate the load might look like this:

```
# Assumes current directory is Loader/python (where loader.py lives)

# (Re)create the tables in Postgres
psql -d postgis -U postgres -f ../extras/ordnancesurvey/vml/pgdump/create-tables.sql

# Run Loader
python loader.py ../extras/ordnancesurvey/vml/pgdump/vml_pgdump.config

# Create spatial indexes
psql -d postgis -U postgres -f ../extras/ordnancesurvey/vml/pgdump/create-indexes.sql
```
