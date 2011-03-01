# Simple OS MasterMap GML/GZ loader #

Author: Matt Walker, Astun Technology Ltd.

Contact: support [at] astuntechnology.com

A very simple OS MasterMap loader written in Python that makes use of [OGR 1.8](http://www.gdal.org/ogr/). Source data can be in GML or GZip (.gz) format and can be output to any of the [formats supported by OGR](http://www.gdal.org/ogr/ogr_formats.html).

## Usage ##

First configure the loader by editing `osmmloader.config` specifying:

### Basic configuration ###

* `src_dir`
  * The directory containing your source OS MasterMap .gml or .gz files. All .gml / .gz files in the specified directory and it's decendents will be loaded.
* `tmp_dir`
  * The directory used to store temporary working files during loading.
* `ogr_cmd`
  * The ogr2ogr command that will be used to load the data. Here you can specify the destination format and any associated settings (for example database connection details if you are writing to PostGIS).

### Advanced configuration ###

* `prep_cmd`
  * The command used to prepare the source data so it is suitable for loading with OGR (does nor normally need changing).
* `ogr_dir`
  * The directory that contains the ogr2ogr utility (can be set to an empty string if ogr2ogr is on your `PATH`).

Then run from the commandline:

`python osmmloader.py config_file`

Additional arguments can be passed to override the values in the config file (usefull when running more than one instance of the loader) for example to specify a different source directory (`src_dir`):

`python osmmloader.py config_file src_dir=./data/tq`
