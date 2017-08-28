# A loader for geographic data in GML and KML #
(that needs some preparation before loading via ogr2ogr)

Author: Astun Technology Ltd.

Contact: support [at] astuntechnology.com

A GML and KML loader written in Python that makes use of [OGR 1.9](http://www.gdal.org/ogr/). Source data can be in GML or KML format (including compressed files in GZ or ZIP format) and can be output to any of the [formats supported by OGR](http://www.gdal.org/ogr/ogr_formats.html). The source data can be prepared using a simple Python to both make it suitable for loading with OGR (useful with complex feature types) or to add value by deriving attributes.

The loader was originally written to load Ordnance Survey OS MasterMap Topographic Layer data in GML/GZ format but has since been used to load other GML and KML data.

## Dependencies ##

* OGR 1.9
  * OGR is part of the [GDAL](http://www.gdal.org/ogr/) suite of tools for translating and manipulation geospatial data.

* Python 2.6+ or 3
  * Python 2.6 or above (including 3) is required. Most modern *Linux* operating systems will already have 2.6 or above.
  * Python lxml module for parsing and manipulating XML

__Installation details are available on the [project wiki](https://github.com/AstunTechnology/Loader/wiki)__

## Usage ##

First configure Loader by editing `loader.config` specifying:

## Changes

See [CHANGELOG.md](./CHANGELOG.md).

### Basic configuration ###

* `src_dir`
  * The directory containing your source files or an individual file. All supported files in the specified directory and it's descendants will be loaded.
* `out_dir`
  * The directory used to store the translated data if writing to a file based format such as ESRI Shape, MapInfo TAB etc.
* `tmp_dir`
  * The directory used to store temporary working files during loading.
* `ogr_cmd`
  * The ogr2ogr command that will be used to load the data. Here you can specify the destination format and any associated settings (for example database connection details if you are writing to PostGIS).
* `prep_cmd`
  * The command used to prepare the source data so it is suitable for loading with OGR, choose one that is suitable for your source data such as prep_osgml.prep_osmm_topo for OS MasterMap Topo.
* `post_cmd`
 * An optional command to be run once OGR has created it's output. Called once per file, useful for loading SQL dump files etc.
* `gfs_file`
  * OGR .gfs file used to define the feature attributes and geometry type of the features read from the GML again choose a suitable gfs file for your source data such as ../gfs/osmm_topo_postgres.gfs for loading OS MasterMap Topo into PostgreSQL.

See `python/loader.config` for further explanation and details of available tokens. Environment variables can be used with any of the options by using a token of the form: `$HOME`, `${HOME}` or `%TEMP%` (Windows only)

Then run from the command-line:

    python loader.py loader.config

Additional arguments can be passed to override the values in the config file (useful when running more than one instance of the loader) for example to specify a different source directory (`src_dir`):

    python loader.py loader.config src_dir=./data/tq

__Some configuration examples are available on the [project wiki](https://github.com/AstunTechnology/Loader/wiki)__

## To-do ##

* Data

    * OS OSMM Water Network Layer
        * Improve support for elements that require an external code list by fetching the code list when it's available
        * Support for nil attributes such as: `<net:inNetwork nilReason="missing" xsi:nil="true" />`, `<hy-n:length xsi:nil="true" uom="m" nilReason="missing" />, `<water:level xsi:nil="true" nilReason="missing" />`
        * Add example to wiki

    * OS MasterMap ITN
        * Add `roadpartiallinkinformation,` `roadpartialrouteinformation` feature types

* Core `loader.py`
    * Specify gfs file via command-line using `GML_GFS_TEMPLATE path_to_template.gfs`
    * Add exception and message when source data is not found
    * Identify errors with subprocess calls and raise
    * Use standard logging instead of print
    * Parallel processing, either:
        * Run `loader.py` instances in parallel one per core each processing a single input file
        * A single `loader.py` process which spawns one process per feature type
            * Would allow using `--config GML_READ_MODE SEQUENTIAL_LAYERS` as each `ogr2ogr` instance would only be loading a single feature type
            * When loading PostgreSQL features could potentially be piped: `prepgml4ogr | ogr2ogr | psql`

* Potential improvements due to changes in OGR
    * Use `--config GML_GFS_TEMPLATE path/to/file.gfs` to specify template instead of copying template file for each source file (requires GDAL 1.9.0)
    * Use `--config GML_READ_MODE SEQUENTIAL_LAYERS` with GML files that include multiple feature types that appear sequentially to avoid the GML being scanned multiple times (requires GDAL 1.9.0)
    * Make use of ability to use GML attributes as feature attributes using the element@attribute syntax in the GFS file (and remove relevant prep logic that creates an element to hold the attribute values) (requires GDAL 1.11.0)
    * Use `/vsigzip/` to read gz directly

## Authors

See [AUTHORS.md](./AUTHORS.md).

## License

MIT, Copyright (c) 2017 Astun Technology Ltd. (http://astuntechnology.com). See [LICENSE.txt](./LICENSE.txt) for full terms.

The logic to apply `style_code` and `style_description` values to OSMM Topography Layer data is derived from the ESRI UK [OSMM-Styling](https://github.com/EsriUK/OSMM-Styling) project licensed under Apache-2.0.
