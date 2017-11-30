-- Loader. Copyright (c) Astun Technology Ltd. (http://astuntechnology.com).
-- Licensed under [MIT License](https://git.io/fAxH0).

-- View: addressbase_premium.addresses_geo

-- DROP VIEW addressbase_premium.addresses_geo;

CREATE OR REPLACE VIEW addressbase_premium.addresses_geo AS 
 SELECT formatted_address.ogc_fid, formatted_address.wkb_geometry, formatted_address.uprn, formatted_address.rm_udprn, ((((ltrim(formatted_address.saon || formatted_address.paon) || formatted_address.street_description) || ', '::text) || formatted_address.localitytown) || ' '::text) || formatted_address.postcode::text AS full_address_caps, (initcap(((ltrim(formatted_address.saon || formatted_address.paon) || formatted_address.street_description) || ', '::text) || formatted_address.localitytown) || ' '::text) || formatted_address.postcode::text AS full_address, formatted_address.postcode
   FROM ( SELECT premium_addresses.ogc_fid, premium_addresses.wkb_geometry, premium_addresses.uprn, premium_addresses.rm_udprn, btrim(((((
                CASE
                    WHEN premium_addresses.organisation_name IS NOT NULL THEN premium_addresses.organisation_name::text || ', '::text
                    ELSE ''::text
                END || 
                CASE
                    WHEN premium_addresses.sao_start_number IS NOT NULL THEN premium_addresses.sao_start_number::text
                    ELSE ''::text
                END) || 
                CASE
                    WHEN premium_addresses.sao_start_suffix IS NOT NULL THEN premium_addresses.sao_start_suffix::text
                    ELSE ''::text
                END) || 
                CASE
                    WHEN premium_addresses.sao_end_number IS NOT NULL THEN '-'::text || premium_addresses.sao_end_number::text
                    ELSE ''::text
                END) || 
                CASE
                    WHEN premium_addresses.sao_end_suffix IS NOT NULL THEN premium_addresses.sao_end_suffix::text
                    ELSE ''::text
                END) || 
                CASE
                    WHEN premium_addresses.sao_text IS NOT NULL THEN (' '::text || premium_addresses.sao_text::text) || ', '::text
                    ELSE ''::text
                END) || ' '::text AS saon, ltrim((((
                CASE
                    WHEN premium_addresses.pao_start_number IS NOT NULL THEN premium_addresses.pao_start_number::text
                    ELSE ''::text
                END || 
                CASE
                    WHEN premium_addresses.pao_start_suffix IS NOT NULL THEN premium_addresses.pao_start_suffix::text
                    ELSE ''::text
                END) || 
                CASE
                    WHEN premium_addresses.pao_end_number IS NOT NULL THEN '-'::text || premium_addresses.pao_end_number::text
                    ELSE ''::text
                END) || 
                CASE
                    WHEN premium_addresses.pao_end_suffix IS NOT NULL THEN premium_addresses.pao_end_suffix::text
                    ELSE ''::text
                END) || 
                CASE
                    WHEN premium_addresses.pao_text IS NOT NULL THEN (' '::text || premium_addresses.pao_text::text) || ', '::text
                    ELSE ' '::text
                END) AS paon, 
                CASE
                    WHEN premium_addresses.street_description IS NOT NULL THEN premium_addresses.street_description::text
                    ELSE ''::text
                END AS street_description, 
                CASE
                    WHEN premium_addresses.locality IS NOT NULL THEN premium_addresses.locality::text || ', '::text
                    ELSE ''::text
                END || 
                CASE
                    WHEN premium_addresses.town_name IS NOT NULL THEN premium_addresses.town_name::text
                    ELSE ''::text
                END AS localitytown, premium_addresses.postcode_locator AS postcode
           FROM ( SELECT row_number() OVER ()::integer AS ogc_fid, b.uprn, b.wkb_geometry, dpa.udprn AS rm_udprn, b.addressbasepostal, b.postcodelocator AS postcode_locator, l.saostartnumber AS sao_start_number, l.saoendnumber AS sao_end_number, l.saostartsuffix AS sao_start_suffix, l.saoendsuffix AS sao_end_suffix, l.saotext AS sao_text, l.paostartnumber AS pao_start_number, l.paoendnumber AS pao_end_number, l.paostartsuffix AS pao_start_suffix, l.saoendsuffix AS pao_end_suffix, l.saotext AS pao_text, s.usrn, s.streetdescription AS street_description, s.locality AS locality, s.townname AS town_name, dpa.organisationname AS organisation_name
                   FROM addressbase_premium.basiclandpropertyunit b
              LEFT JOIN addressbase_premium.landpropertyidentifier l ON b.uprn = l.uprn
         LEFT JOIN addressbase_premium.deliverypointaddress dpa ON b.uprn = dpa.uprn
    LEFT JOIN addressbase_premium.streetdescriptiveidentifier s ON l.usrn::double precision = s.usrn) premium_addresses) formatted_address;

ALTER TABLE addressbase_premium.addresses_geo
  OWNER TO postgres;
COMMENT ON VIEW addressbase_premium.addresses_geo
  IS 'Simple, nicely formatted view of AddressBase (premium) geographic addresses in PostgreSQL that has been imported with Loader!

     Author: Mike Saunt, Astun Technology Ltd
     Version 0.1 - 15th November 2013

    https://github.com/AstunTechnology/Loader
';

