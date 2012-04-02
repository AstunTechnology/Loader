# A simple loader for geographic data in GML and KML #
(that needs some preparation before loading via ogr2ogr)

Author: Matt Walker, Astun Technology Ltd.

Contact: support [at] astuntechnology.com

A simple GML loader written in Python that makes use of [OGR 1.8](http://www.gdal.org/ogr/). Source data can be in GML or KML format (including compressed files in GZ or ZIP format) and can be output to any of the [formats supported by OGR](http://www.gdal.org/ogr/ogr_formats.html). The source data can be prepared using a simple Python to both make it suitable for loading with OGR (useful with complex feature types) or to add value by deriving attributes.

The loader was originally written to load Ordnance Survey OS MasterMap Topographic Layer data in GML/GZ format but has since been used to load other GML and KML data.

## Dependencies ##

* OGR 1.8
  * OGR is part of the [GDAL](http://www.gdal.org/ogr/) suite of tools for translating and manipulation geospatial data.
  * *Windows* users can use [OSGeo4W](http://trac.osgeo.org/osgeo4w/) (choose Advanced install and select GDAL under the Commandline_Utilities section). You can then run the loader using the OSGeo4W Shell which will have OGR available.
  * *Linux* users see [GDAL Downloads](http://trac.osgeo.org/gdal/wiki/DownloadingGdalBinaries).

* Python 2.6+ or 3
  * Python 2.6 or above (including 3) is required. Most modern *Linux* operating systems will already have 2.6 or above. *Windows* users can download Python from the [Python Downloads page](http://www.python.org/download/releases/).
  * Python lxml module for parsing and manipulating XML, Windows users can download from the [lxml project page](http://pypi.python.org/pypi/lxml/2.3/), *Linux* users can usually install via their package manager (Ubuntu users would use: `sudo apt-get install python-lxml`)

Further install details are available on the [project wiki](https://github.com/AstunTechnology/Loader/wiki)

## Usage ##

First configure the loader by editing 'loader.config' specifying:

### Basic configuration ###

* 'src_dir'
  * The directory containing your source files. All supported files in the specified directory and it's descendants will be loaded.
* 'out_dir'
  * The directory used to store the translated data if writing to a file based format such as ESRI Shape, MapInfo TAB etc.
* 'tmp_dir'
  * The directory used to store temporary working files during loading.
* 'ogr_cmd'
  * The ogr2ogr command that will be used to load the data. Here you can specify the destination format and any associated settings (for example database connection details if you are writing to PostGIS).
* 'prep_cmd'
  * The command used to prepare the source data so it is suitable for loading with OGR, choose one that is suitable for your source data such as prep_osgml.prep_osmm_topo for OS MasterMap Topo.
* 'gfs_file'
  * OGR .gfs file used to define the feature attributes and geometry type of the feautes read from the GML again choose a suitable gfs file for your source data such as ../gfs/osmm_topo_postgres.gfs for loading OS MasterMap Topo in to PostgreSQL.

Then run from the commandline:

'python loader.py loader.config'

Additional arguments can be passed to override the values in the config file (useful when running more than one instance of the loader) for example to specify a different source directory ('src_dir'):

'python loader.py config_file src_dir=./data/tq'

Some configuration examples are available on the [project wiki](https://github.com/AstunTechnology/Loader/wiki)
