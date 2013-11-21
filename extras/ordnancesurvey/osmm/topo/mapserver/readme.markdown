# A  mapserver include file for styling Mastermap data loaded using Loader#

Contact: support [at] astuntechnology.com

A mapserver include file for Ordnance Survey Mastermap topographic data as loaded into PostgreSQL via Loader.

## Assumptions ##

 * Assumes that the data is in a PostgreSQL database- edit this if your data is stored in a different vector format. 
 * The connection details for the database are stored in a file called pg\_connection.inc, stored in the same directory as your mapserver map file. Edit this as appropriate. See [here](http://mapserver.org/input/vector/postgis.html#data-access-connection-method) for information on the connection parameters that should be in pg\_connection.inc
 * The data is in a schema called "mapping"- edit as appropriate

