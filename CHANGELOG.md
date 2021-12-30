# Changelog

All notable changes to Loader will be documented in this file.

## [Unreleased]

None

## [1.2.1] - 2021-12-30

* Fix issues loading OSMM Topo with Python 3, should support Python 2.7 and 3

## [1.2.0] - 2021-12-22

* Add support for loading OS Terrain - @coastalrocket
* Support `out_dir` as well as existing `output_dir` placeholder in `ogr_cmd` and `post_cmd`
* Set the encoding of the text output by the `prep_cmd` to `UTF-8`

## [1.1.0] - 2019-04-05

* Update VectorMap Local to match new schema - @coastalrocket, @walkermatt
* Add OSMM Highways support - @aileenheal, @archaeogeek, @GeoWill, @coastalrocket, @walkermatt

## [1.0.1] - 2017-11-28

* Update VectorMap District to match new schema - @thomparker
* Add CONTRIBUTING doc - @archaeogeek

## [1.0.0] - 2017-07-10

Loader has been around since 2011 but has been without an official release; lets start now ;-)

### Changed

* Fixes for OS AddressBase preparation and `.gfs` config
