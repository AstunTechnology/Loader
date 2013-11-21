-- View: addressbase_plus.addresses_geo

-- DROP VIEW addressbase_plus.addresses_geo;

CREATE OR REPLACE VIEW addressbase_plus.addresses_geo AS
 SELECT formatted_address.ogc_fid, formatted_address.wkb_geometry, formatted_address.uprn, formatted_address.rm_udprn, ((((ltrim(formatted_address.saon || formatted_address.paon) || formatted_address.street_description) || ', '::text) || formatted_address.localitytown) || ' '::text) || formatted_address.postcode::text AS full_address_caps, (initcap(((ltrim(formatted_address.saon || formatted_address.paon) || formatted_address.street_description) || ', '::text) || formatted_address.localitytown) || ' '::text) || formatted_address.postcode::text AS full_address, formatted_address.postcode
   FROM ( SELECT address.ogc_fid, address.wkb_geometry, address.uprn, address.rm_udprn, btrim(((((
                CASE
                    WHEN address.organisation_name IS NOT NULL THEN address.organisation_name::text || ', '::text
                    ELSE ''::text
                END || 
                CASE
                    WHEN address.sao_start_number IS NOT NULL THEN address.sao_start_number::text
                    ELSE ''::text
                END) || 
                CASE
                    WHEN address.sao_start_suffix IS NOT NULL THEN address.sao_start_suffix::text
                    ELSE ''::text
                END) || 
                CASE
                    WHEN address.sao_end_number IS NOT NULL THEN '-'::text || address.sao_end_number::text
                    ELSE ''::text
                END) || 
                CASE
                    WHEN address.sao_end_suffix IS NOT NULL THEN address.sao_end_suffix::text
                    ELSE ''::text
                END) || 
                CASE
                    WHEN address.sao_text IS NOT NULL THEN (' '::text || address.sao_text::text) || ', '::text
                    ELSE ''::text
                END) || ' '::text AS saon, ltrim((((
                CASE
                    WHEN address.pao_start_number IS NOT NULL THEN address.pao_start_number::text
                    ELSE ''::text
                END || 
                CASE
                    WHEN address.pao_start_suffix IS NOT NULL THEN address.pao_start_suffix::text
                    ELSE ''::text
                END) || 
                CASE
                    WHEN address.pao_end_number IS NOT NULL THEN '-'::text || address.pao_end_number::text
                    ELSE ''::text
                END) || 
                CASE
                    WHEN address.pao_end_suffix IS NOT NULL THEN address.pao_end_suffix::text
                    ELSE ''::text
                END) || 
                CASE
                    WHEN address.pao_text IS NOT NULL THEN (' '::text || address.pao_text::text) || ', '::text
                    ELSE ' '::text
                END) AS paon, 
                CASE
                    WHEN address.street_description IS NOT NULL THEN address.street_description::text
                    ELSE ''::text
                END AS street_description, 
                CASE
                    WHEN address.locality IS NOT NULL THEN address.locality::text || ', '::text
                    ELSE ''::text
                END || 
                CASE
                    WHEN address.town_name IS NOT NULL THEN address.town_name::text
                    ELSE ''::text
                END AS localitytown, address.postcode_locator AS postcode
           FROM addressbase_plus.address
          WHERE address.class::text <> 'PP'::text AND address.class::text <> 'PS'::text) formatted_address;

ALTER TABLE addressbase_plus.addresses_geo
  OWNER TO postgres;
COMMENT ON VIEW addressbase_plus.addresses_geo
  IS 'Simple, nicely formatted view of AddressBase (plus) geographic addresses in PostgreSQL that has been imported with Loader!

     Author: Mike Saunt, Astun Technology Ltd
     Version 0.1 - 15th November 2013
     © Copyright 2013

    https://github.com/AstunTechnology/Loader
';

