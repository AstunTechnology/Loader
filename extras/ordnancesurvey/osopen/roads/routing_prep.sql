-- Loader. Copyright (c) Astun Technology Ltd. (http://astuntechnology.com).
-- Licensed under [MIT License](https://git.io/fAxH0).

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



--drop materialized view osopen.routing_roadlink;

create materialized view osopen.routing_roadlink as
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
name1 as name,
roadclassificationnumber ,
  strategicroad ,
  name2 ,
  name1_lang as name_lang,
  structure ,
  name2_lang ,
  formspartof 
from osopen.roadlink;


--drop materialized view osopen.routing_roadnode;

create materialized view osopen.routing_roadnode as
  select
 ogc_fid ,
  regexp_replace(gml_id, '^L0*', '')::int nodeid,
  formofroadnode,
  wkb_geometry 
from osopen.roadnode;

create unique index routing_roadnode_pk 
on osopen.routing_roadnode(nodeid);

create index routing_roadnode_gix on osopen.routing_roadnode using GIST (wkb_geometry);

-- fix roadlink lines where direction of digitisation is incorrect (goes from end node to start node)

update osopen.roadlink
   set wkb_geometry = st_reverse(wkb_geometry)
 where ogc_fid in (select l.ogc_fid
                     from osopen.routing_roadlink l , osopen.routing_roadnode sn, osopen.routing_roadnode en
                    where l.startnode = sn.nodeid
                      and l.endnode = en.nodeid
                      and st_distance(st_startpoint(l.wkb_geometry), sn.wkb_geometry) > 0.1
                      and st_distance(st_startpoint(l.wkb_geometry), en.wkb_geometry) < 0.1 );

create unique index routing_roadlink_pk 
on osopen.routing_roadlink(gml_id);

create index routing_roadlink_gix on osopen.routing_roadlink using gist (wkb_geometry);

create index routing_roadlink_idx1 on osopen.routing_roadlink(startnode);

create index routing_roadlink_idx2 on osopen.routing_roadlink(endnode);   