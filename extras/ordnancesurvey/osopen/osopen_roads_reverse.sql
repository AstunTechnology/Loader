-- fix roadlink lines where direction of digitisation is incorrect (goes from end node to start node)

update osopen.roadlink
   set wkb_geometry = st_reverse(wkb_geometry)
 where ogc_fid in (select l.ogc_fid
                     from osopen.mv_roadlink l , osopen.mv_roadnode sn, osopen.mv_roadnode en
                    where l.startnode = sn.nodeid
                      and l.endnode = en.nodeid
                      and st_distance(st_startpoint(l.wkb_geometry), sn.wkb_geometry) > 0.1
                      and st_distance(st_startpoint(l.wkb_geometry), en.wkb_geometry) < 0.1 );

refresh materialized view osopen.mv_roadlink;

refresh materialized view osopen.mv_roadnode;