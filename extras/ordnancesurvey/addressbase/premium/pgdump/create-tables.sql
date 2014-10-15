-- Drops any existing AddressBase Premium tables and creates fresh tables to recieve data

DROP TABLE "addressbase_premium"."basiclandpropertyunit" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'basiclandpropertyunit' AND f_table_schema = 'addressbase_premium';

CREATE TABLE "addressbase_premium"."basiclandpropertyunit" ( OGC_FID SERIAL, CONSTRAINT "basiclandpropertyunit_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('addressbase_premium','basiclandpropertyunit','wkb_geometry',27700,'POINT',2);
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "uprn" FLOAT8;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "logicalstatus" INTEGER;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "blpustate" INTEGER;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "blpustatedate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "parentuprn" FLOAT8;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "rpc" INTEGER;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "localcustodiancode" INTEGER;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "postaladdressable" VARCHAR(1);
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "postcodelocator" VARCHAR(8);
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "multiocccount" INTEGER;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "changetype" VARCHAR(1);
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "startdate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "enddate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "entrydate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "lastupdatedate" VARCHAR(10);

DROP TABLE "addressbase_premium"."classification" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'classification' AND f_table_schema = 'addressbase_premium';

CREATE TABLE "addressbase_premium"."classification" ( OGC_FID SERIAL, CONSTRAINT "classification_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('addressbase_premium','classification','wkb_geometry',-1,'GEOMETRY',2);
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "uprn" FLOAT8;
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "classkey" VARCHAR(14);
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "classificationcode" VARCHAR(6);
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "classscheme" VARCHAR(60);
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "schemeversion" VARCHAR(4);
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "startdate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "entrydate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "lastupdatedate" VARCHAR(10);

DROP TABLE "addressbase_premium"."deliverypointaddress" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'deliverypointaddress' AND f_table_schema = 'addressbase_premium';

CREATE TABLE "addressbase_premium"."deliverypointaddress" ( OGC_FID SERIAL, CONSTRAINT "deliverypointaddress_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('addressbase_premium','deliverypointaddress','wkb_geometry',-1,'GEOMETRY',2);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "uprn" FLOAT8;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "rmudprn" NUMERIC(8,0);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "parentaddressableuprn" NUMERIC(12,0);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "organisationname" VARCHAR(60);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "departmentname" VARCHAR(60);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "subbuildingname" VARCHAR(30);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "buildingname" VARCHAR(30);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "buildingnumber" NUMERIC(4,0);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "dependentthoroughfarename" VARCHAR(80);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "thoroughfarename" VARCHAR(80);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "doubledependentlocality" VARCHAR(35);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "dependentlocality" VARCHAR(35);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "posttown" VARCHAR(30);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "postcode" VARCHAR(8);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "postcodetype" VARCHAR(1);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "welshdependentthoroughfarename" VARCHAR(80);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "welshthoroughfarename" VARCHAR(80);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "welshdoubledependentlocality" VARCHAR(35);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "welshdependentlocality" VARCHAR(35);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "welshposttown" VARCHAR(30);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "poboxnumber" VARCHAR(6);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "processdate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "startdate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "entrydate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "lastupdatedate" VARCHAR(10);

DROP TABLE "addressbase_premium"."landpropertyidentifier" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'landpropertyidentifier' AND f_table_schema = 'addressbase_premium';

CREATE TABLE "addressbase_premium"."landpropertyidentifier" ( OGC_FID SERIAL, CONSTRAINT "landpropertyidentifier_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('addressbase_premium','landpropertyidentifier','wkb_geometry',-1,'GEOMETRY',2);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "uprn" FLOAT8;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "lpikey" VARCHAR(14);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "logicalstatus" NUMERIC(1,0);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "saostartnumber" NUMERIC(4,0);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "saostartsuffix" VARCHAR(2);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "saoendnumber" NUMERIC(4,0);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "saoendsuffix" VARCHAR(2);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "saotext" VARCHAR(90);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "paostartnumber" NUMERIC(4,0);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "paostartsuffix" VARCHAR(2);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "paoendnumber" NUMERIC(4,0);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "paoendsuffix" VARCHAR(2);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "paotext" VARCHAR(90);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "usrn" NUMERIC(8,0);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "usrnmatchindicator" VARCHAR(1);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "areaname" VARCHAR(35);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "level" VARCHAR(30);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "officialflag" VARCHAR(1);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "startdate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "entrydate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "lastupdatedate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "lang" VARCHAR(3);

DROP TABLE "addressbase_premium"."organisation" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'organisation' AND f_table_schema = 'addressbase_premium';

CREATE TABLE "addressbase_premium"."organisation" ( OGC_FID SERIAL, CONSTRAINT "organisation_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('addressbase_premium','organisation','wkb_geometry',-1,'GEOMETRY',2);
ALTER TABLE "addressbase_premium"."organisation" ADD COLUMN "uprn" FLOAT8;
ALTER TABLE "addressbase_premium"."organisation" ADD COLUMN "orgkey" VARCHAR(14);
ALTER TABLE "addressbase_premium"."organisation" ADD COLUMN "organisation" VARCHAR(100);
ALTER TABLE "addressbase_premium"."organisation" ADD COLUMN "legalname" VARCHAR(60);
ALTER TABLE "addressbase_premium"."organisation" ADD COLUMN "startdate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."organisation" ADD COLUMN "entrydate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."organisation" ADD COLUMN "lastupdatedate" VARCHAR(10);

DROP TABLE "addressbase_premium"."applicationcrossreference" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'applicationcrossreference' AND f_table_schema = 'addressbase_premium';

CREATE TABLE "addressbase_premium"."applicationcrossreference" ( OGC_FID SERIAL, CONSTRAINT "applicationcrossreference_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('addressbase_premium','applicationcrossreference','wkb_geometry',-1,'GEOMETRY',2);
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "uprn" FLOAT8;
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "xrefkey" VARCHAR(14);
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "crossreference" VARCHAR(50);
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "version" NUMERIC(3,0);
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "source" VARCHAR(6);
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "startdate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "entrydate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "lastupdatedate" VARCHAR(10);

DROP TABLE "addressbase_premium"."street" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'street' AND f_table_schema = 'addressbase_premium';

CREATE TABLE "addressbase_premium"."street" ( OGC_FID SERIAL, CONSTRAINT "street_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('addressbase_premium','street','wkb_geometry',27700,'MULTIPOINT',2);
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "usrn" FLOAT8;
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "recordtype" NUMERIC(1,0);
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "swaorgrefnaming" NUMERIC(4,0);
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "state" NUMERIC(1,0);
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "statedate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "streetsurface" NUMERIC(1,0);
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "streetclassification" NUMERIC(2,0);
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "version" NUMERIC(3,0);
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "streettolerance" NUMERIC(3,0);
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "startdate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "enddate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "lastupdatedate" VARCHAR(10);

DROP TABLE "addressbase_premium"."streetdescriptiveidentifier" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'streetdescriptiveidentifier' AND f_table_schema = 'addressbase_premium';

CREATE TABLE "addressbase_premium"."streetdescriptiveidentifier" ( OGC_FID SERIAL, CONSTRAINT "streetdescriptiveidentifier_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('addressbase_premium','streetdescriptiveidentifier','wkb_geometry',-1,'GEOMETRY',2);
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "usrn" FLOAT8;
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "streetdescription" VARCHAR(100);
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "localityname" VARCHAR(35);
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "townname" VARCHAR(30);
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "administrativearea" VARCHAR(30);
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "lang" VARCHAR(3);
