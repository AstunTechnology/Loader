-- Lookup between road and roadlink on fid
CREATE OR REPLACE VIEW osmm_itn.road_roadlink AS
SELECT road_fid,
       replace(roadlink_fid, '#', '') AS roadlink_fid
FROM
  (SELECT fid AS road_fid,
          unnest(networkmember_href) AS roadlink_fid
   FROM osmm_itn.road) AS a;

-- Each roadlink with associated roadname(s) and fid of road in case more info
-- is required
CREATE OR REPLACE VIEW osmm_itn.roads AS
SELECT array_to_string(road.roadname, ', ', '') AS roadname,
       road.fid AS road_fid,
       roadlink.*
FROM osmm_itn.roadlink AS roadlink
LEFT JOIN osmm_itn.road_roadlink AS road_roadlink ON (roadlink.fid = road_roadlink.roadlink_fid)
LEFT JOIN osmm_itn.road AS road ON (road_roadlink.road_fid = road.fid);
