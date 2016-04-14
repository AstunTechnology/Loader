-- View: addressbase_premium.addresses_postal

-- DROP VIEW addressbase_premium.addresses_postal;

CREATE OR REPLACE VIEW addressbase_premium.addresses_postal AS 
 SELECT blpu.ogc_fid, blpu.wkb_geometry, blpu.uprn, dpa.udprn AS rm_udprn, (((((((((
        CASE
            WHEN dpa.organisationname IS NOT NULL THEN dpa.organisationname::text || ', '::text
            ELSE ''::text
        END || 
        CASE
            WHEN dpa.departmentname IS NOT NULL THEN dpa.departmentname::text || ', '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.subbuildingname IS NOT NULL THEN dpa.subbuildingname::text || ', '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.buildingname IS NOT NULL THEN dpa.buildingname::text || ', '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.buildingnumber > 0::numeric THEN dpa.buildingnumber::text || ' '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.dependentthoroughfare IS NOT NULL THEN dpa.dependentthoroughfare::text || ', '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.thoroughfare IS NOT NULL THEN dpa.thoroughfare::text || ', '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.doubledependentlocality IS NOT NULL THEN dpa.doubledependentlocality::text || ', '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.dependentlocality IS NOT NULL THEN dpa.dependentlocality::text || ', '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.posttown IS NOT NULL THEN dpa.posttown::text || ' '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.postcode IS NOT NULL THEN dpa.postcode
            ELSE ''::character varying
        END::text AS full_address_caps, (((((((((
        CASE
            WHEN dpa.organisationname IS NOT NULL THEN initcap(dpa.organisationname::text) || ', '::text
            ELSE ''::text
        END || 
        CASE
            WHEN dpa.departmentname IS NOT NULL THEN initcap(dpa.departmentname::text) || ', '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.subbuildingname IS NOT NULL THEN initcap(dpa.subbuildingname::text) || ', '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.buildingname IS NOT NULL THEN initcap(dpa.buildingname::text) || ', '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.buildingnumber > 0::numeric THEN dpa.buildingnumber::text || ' '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.dependentthoroughfare IS NOT NULL THEN initcap(dpa.dependentthoroughfare::text) || ', '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.thoroughfare IS NOT NULL THEN initcap(dpa.thoroughfare::text) || ', '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.doubledependentlocality IS NOT NULL THEN initcap(dpa.doubledependentlocality::text) || ', '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.dependentlocality IS NOT NULL THEN initcap(dpa.dependentlocality::text) || ', '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.posttown IS NOT NULL THEN initcap(dpa.posttown::text) || ' '::text
            ELSE ''::text
        END) || 
        CASE
            WHEN dpa.postcode IS NOT NULL THEN dpa.postcode
            ELSE ''::character varying
        END::text AS full_address, 
        CASE
            WHEN dpa.postcode IS NOT NULL THEN dpa.postcode
            ELSE ''::character varying
        END AS postcode
   FROM addressbase_premium.deliverypointaddress dpa
   LEFT JOIN addressbase_premium.basiclandpropertyunit blpu ON dpa.uprn = blpu.uprn;

ALTER TABLE addressbase_premium.addresses_postal
  OWNER TO postgres;
COMMENT ON VIEW addressbase_premium.addresses_postal
  IS 'Simple, nicely formatted view of AddressBase Premium postal addresses in PostgreSQL that has been imported with Loader

     Author: Mike Saunt, Astun Technology Ltd
     Version 0.1 - 15th November 2013

    https://github.com/AstunTechnology/Loader
';

