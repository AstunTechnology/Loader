-- Drops any existing AddressBase Premium tables and creates fresh tables to recieve data

DROP TABLE "addressbase_premium"."basiclandpropertyunit" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'basiclandpropertyunit' AND f_table_schema = 'addressbase_premium';

CREATE TABLE "addressbase_premium"."basiclandpropertyunit" ( OGC_FID SERIAL, CONSTRAINT "basiclandpropertyunit_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('addressbase_premium','basiclandpropertyunit','wkb_geometry',27700,'POINT',2);
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "uprn" FLOAT8;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "logicalstatus" INTEGER;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "blpustate" INTEGER;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "blpustatedate" VARCHAR;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "parentuprn" FLOAT8;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "rpc" INTEGER;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "localcustodiancode" INTEGER;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "country" VARCHAR(1);
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "addressbasepostal" VARCHAR(1);
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "postcodelocator" VARCHAR;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "multiocccount" INTEGER;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "changetype" VARCHAR;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "startdate" VARCHAR;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "enddate" VARCHAR;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "entrydate" VARCHAR;
ALTER TABLE "addressbase_premium"."basiclandpropertyunit" ADD COLUMN "lastupdatedate" VARCHAR;

DROP TABLE "addressbase_premium"."classification" CASCADE;
CREATE TABLE "addressbase_premium"."classification" (    OGC_FID SERIAL,    CONSTRAINT "classification_pk" PRIMARY KEY (OGC_FID) );
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "uprn" FLOAT8;
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "classkey" VARCHAR;
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "classificationcode" VARCHAR;
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "classscheme" VARCHAR;
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "schemeversion" INTEGER;
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "startdate" VARCHAR;
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "entrydate" VARCHAR;
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "lastupdatedate" VARCHAR;
ALTER TABLE "addressbase_premium"."classification" ADD COLUMN "enddate" VARCHAR(10);

DROP TABLE "addressbase_premium"."deliverypointaddress" CASCADE;

CREATE TABLE "addressbase_premium"."deliverypointaddress" (    OGC_FID SERIAL,    CONSTRAINT "deliverypointaddress_pk" PRIMARY KEY (OGC_FID) );
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "uprn" FLOAT8;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "udprn" INTEGER;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "organisationname" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "departmentname" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "subbuildingname" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "buildingname" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "buildingnumber" INTEGER;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "dependentthoroughfare" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "thoroughfare" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "doubledependentlocality" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "dependentlocality" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "posttown" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "postcode" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "postcodetype" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "welshdependentthoroughfare" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "welshthoroughfare" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "welshdoubledependentlocality" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "welshdependentlocality" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "welshposttown" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "poboxnumber" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "deliverypointsuffix" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "processdate" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "startdate" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "entrydate" VARCHAR;
ALTER TABLE "addressbase_premium"."deliverypointaddress" ADD COLUMN "lastupdatedate" VARCHAR;

DROP TABLE "addressbase_premium"."landpropertyidentifier" CASCADE;

CREATE TABLE "addressbase_premium"."landpropertyidentifier" (    OGC_FID SERIAL,    CONSTRAINT "landpropertyidentifier_pk" PRIMARY KEY (OGC_FID) );
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "uprn" FLOAT8;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "lpikey" VARCHAR;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "logicalstatus" INTEGER;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "saostartnumber" INTEGER;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "saostartsuffix" VARCHAR;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "saoendnumber" INTEGER;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "saoendsuffix" VARCHAR;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "saotext" VARCHAR;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "paostartnumber" INTEGER;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "paostartsuffix" VARCHAR;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "paoendnumber" INTEGER;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "paoendsuffix" VARCHAR;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "paotext" VARCHAR;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "usrn" INTEGER;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "usrnmatchindicator" INTEGER;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "officialflag" VARCHAR;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "startdate" VARCHAR;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "entrydate" VARCHAR;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "lastupdatedate" VARCHAR;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "lang" VARCHAR;
ALTER TABLE "addressbase_premium"."landpropertyidentifier" ADD COLUMN "enddate" VARCHAR;

DROP TABLE "addressbase_premium"."organisation" CASCADE;

CREATE TABLE "addressbase_premium"."organisation" (    OGC_FID SERIAL,    CONSTRAINT "organisation_pk" PRIMARY KEY (OGC_FID) );
ALTER TABLE "addressbase_premium"."organisation" ADD COLUMN "uprn" FLOAT8;
ALTER TABLE "addressbase_premium"."organisation" ADD COLUMN "orgkey" VARCHAR;
ALTER TABLE "addressbase_premium"."organisation" ADD COLUMN "organisation" VARCHAR;
ALTER TABLE "addressbase_premium"."organisation" ADD COLUMN "startdate" VARCHAR;
ALTER TABLE "addressbase_premium"."organisation" ADD COLUMN "entrydate" VARCHAR;
ALTER TABLE "addressbase_premium"."organisation" ADD COLUMN "lastupdatedate" VARCHAR;
ALTER TABLE "addressbase_premium"."organisation" ADD COLUMN "enddate" VARCHAR(10);

DROP TABLE "addressbase_premium"."applicationcrossreference" CASCADE;

CREATE TABLE "addressbase_premium"."applicationcrossreference" (    OGC_FID SERIAL,    CONSTRAINT "applicationcrossreference_pk" PRIMARY KEY (OGC_FID) );
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "uprn" FLOAT8;
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "xrefkey" VARCHAR;
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "crossreference" VARCHAR;
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "version" INTEGER;
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "source" VARCHAR;
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "startdate" VARCHAR;
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "entrydate" VARCHAR;
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "lastupdatedate" VARCHAR;
ALTER TABLE "addressbase_premium"."applicationcrossreference" ADD COLUMN "enddate" VARCHAR(10);

DROP TABLE "addressbase_premium"."street" CASCADE;
DELETE FROM geometry_columns WHERE f_table_name = 'street' AND f_table_schema = 'addressbase_premium';

CREATE TABLE "addressbase_premium"."street" ( OGC_FID SERIAL, CONSTRAINT "street_pk" PRIMARY KEY (OGC_FID) );
SELECT AddGeometryColumn('addressbase_premium','street','wkb_geometry',27700,'MULTIPOINT',2);
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "usrn" INTEGER;
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "recordtype" INTEGER;
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "swaorgrefnaming" INTEGER;
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "state" INTEGER;
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "statedate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "streetsurface" INTEGER;
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "streetclassification" INTEGER;
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "version" INTEGER;
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "streettolerance" INTEGER;
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "startdate" VARCHAR;
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "enddate" VARCHAR;
ALTER TABLE "addressbase_premium"."street" ADD COLUMN "lastupdatedate" VARCHAR;

DROP TABLE "addressbase_premium"."streetdescriptiveidentifier" CASCADE;

CREATE TABLE "addressbase_premium"."streetdescriptiveidentifier" (    OGC_FID SERIAL,    CONSTRAINT "streetdescriptiveidentifier_pk" PRIMARY KEY (OGC_FID) );
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "usrn" INTEGER;
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "streetdescription" VARCHAR;
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "locality" VARCHAR;
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "townname" VARCHAR;
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "administrativearea" VARCHAR;
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "lang" VARCHAR(2);
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "changetype" VARCHAR(1);
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "startdate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "entrydate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "lastupdatedate" VARCHAR(10);
ALTER TABLE "addressbase_premium"."streetdescriptiveidentifier" ADD COLUMN "enddate" VARCHAR(10);
