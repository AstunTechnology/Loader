--remove duplicated roadlink and roadnodes

select count(*) from 
              (SELECT ogc_fid,
                      row_number() over (partition BY gml_id ORDER BY ogc_fid) AS rnum
                 FROM osopen.roadlink) t
                WHERE t.rnum > 1;   

select count(*) from 
              (SELECT ogc_fid,
                      row_number() over (partition BY gml_id ORDER BY ogc_fid) AS rnum
                 FROM osopen.roadnode) t
                WHERE t.rnum > 1; 


delete from osopen.roadlink 
where ogc_fid in ( select id 
                   from (SELECT ogc_fid id,
                                row_number() over (partition BY gml_id ORDER BY ogc_fid) AS rnum
                           FROM osopen.roadlink) t
                   WHERE t.rnum > 1);


delete from osopen.roadnode 
where ogc_fid in ( select id 
                  from (SELECT ogc_fid id,
                               row_number() over (partition BY gml_id ORDER BY ogc_fid) AS rnum
                          FROM osopen.roadnode) t
                   WHERE t.rnum > 1);


select count(*) from 
              (SELECT ogc_fid,
                      row_number() over (partition BY gml_id ORDER BY ogc_fid) AS rnum
                 FROM osopen.roadlink) t
                WHERE t.rnum > 1;   

select count(*) from 
              (SELECT ogc_fid,
                      row_number() over (partition BY gml_id ORDER BY ogc_fid) AS rnum
                 FROM osopen.roadnode) t
                WHERE t.rnum > 1;  

--drop materialized view osopen.mv_roadlink;

create materialized view osopen.mv_roadlink as
select ogc_fid, wkb_geometry, gml_id, cast(fictitious as boolean), 
regexp_replace(startnode, '^#L0*', '')::int startnode,
regexp_replace(endnode, '^#L0*', '')::int endnode,
length,
length_uom,
roadclassification,
formofway,
case 
  when roadclassification = 'Motorway' then length/110000 -- 110 km/hr = 70 m/hr
  when roadclassification = 'A Road' then length/100000   -- 100 km/hr = 60 m/hr
  when roadclassification = 'B Road' then length/65000    -- 65 km/hr = 40 m/hr
  else length/50000 --  50 km/hr = 30 m/hr
end as cost_car,
case 
  when roadclassification = 'Motorway' then length/0.000001
  else length/16000  -- 10 m/hr 
end as cost_bike,
cast(loop as boolean),
name,
roadclassificationnumber ,
  strategicroad ,
  name2 ,
  name_lang ,
  structure ,
  name2_lang ,
  formspartof 
from osopen.roadlink;

create unique index mv_roadlink_pk 
on osopen.mv_roadlink(gml_id);

create index mv_roadlink_gix on osopen.mv_roadlink using gist (wkb_geometry);

create index mv_roadlink_idx1 on osopen.mv_roadlink(startnode);

create index mv_roadlink_idx2 on osopen.mv_roadlink(endnode);                    

--drop materialized view osopen.mv_roadnode;

create materialized view osopen.mv_roadnode as
  select
 ogc_fid ,
  regexp_replace(gml_id, '^L0*', '')::int nodeid,
  formofroadnode,
  wkb_geometry 
from osopen.roadnode;

create unique index mv_roadnode_pk 
on osopen.mv_roadnode(nodeid);

create index mv_roadnode_gix on osopen.mv_roadnode using GIST (wkb_geometry);