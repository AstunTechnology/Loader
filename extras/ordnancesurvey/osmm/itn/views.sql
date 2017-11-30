-- Loader. Copyright (c) Astun Technology Ltd. (http://astuntechnology.com).
-- Licensed under [MIT License](https://git.io/fAxH0).

-- Lookup between road and roadlink on fid
CREATE OR REPLACE VIEW osmm_itn.road_roadlink AS
SELECT road_fid,
       replace(roadlink_fid, '#', '') AS roadlink_fid
FROM
  (SELECT fid AS road_fid,
          unnest(networkmember_href) AS roadlink_fid
   FROM osmm_itn.road) AS a;

-- Lookup between roadlink and the roadnodes at it's start and end
CREATE OR REPLACE VIEW osmm_itn.roadlink_roadnode AS
SELECT a.roadlink_fid,
       replace(a.roadnode_fid::text, '#', '') AS roadnode_fid,
       a.directednode_orientation,
       a.directednode_gradeseparation
FROM
    (SELECT roadlink.fid AS roadlink_fid,
            unnest(roadlink.directednode_href) AS roadnode_fid,
            unnest(roadlink.directednode_orientation) AS directednode_orientation,
            unnest(roadlink.directednode_gradeseparation) AS directednode_gradeseparation
     FROM osmm_itn.roadlink) AS a;

-- Lookup between ferrylink and ferrynode on fid
CREATE OR REPLACE VIEW osmm_itn.ferrylink_ferrynode AS
SELECT ferrylink_fid,
       replace(ferrynode_fid, '#', '') AS ferrynode_fid
FROM
  (SELECT fid AS ferrylink_fid,
          unnest(directednode_href) AS ferrynode_fid
   FROM osmm_itn.ferrylink) AS a;

-- Lookup between ferryterminal and ferrynode on fid. A duplicate of
-- ferryterminal_roadnode as ferryterminal.referencetonetwork_href references
-- both ferrynode and roadnode
CREATE OR REPLACE VIEW osmm_itn.ferryterminal_ferrynode AS
SELECT ferryterminal_fid,
       replace(ferrynode_fid, '#', '') AS ferrynode_fid
FROM
  (SELECT fid AS ferryterminal_fid,
          unnest(referencetonetwork_href) AS ferrynode_fid
   FROM osmm_itn.ferryterminal) AS a;

-- Lookup between ferryterminal and roadnode on fid. A duplicate of
-- ferryterminal_ferrynode as ferryterminal.referencetonetwork_href references
-- both ferrynode and roadnode
CREATE OR REPLACE VIEW osmm_itn.ferryterminal_roadnode AS
SELECT ferryterminal_fid,
       replace(roadnode_fid, '#', '') AS roadnode_fid
FROM
  (SELECT fid AS ferryterminal_fid,
          unnest(referencetonetwork_href) AS roadnode_fid
   FROM osmm_itn.ferryterminal) AS a;

-- Lookup between roadrouteinformation and roadlink on fid including the order
-- of each roadlink associated with a given roadrouteinformation row
CREATE OR REPLACE VIEW osmm_itn.roadrouteinformation_roadlink AS
SELECT roadrouteinformation_fid,
       replace(roadlink_fid, '#', '') AS roadlink_fid,
       roadlink_order
FROM
  (SELECT fid AS roadrouteinformation_fid,
          unnest(directedlink_href) AS roadlink_fid,
          generate_subscripts(directedlink_href, 1) AS roadlink_order
   FROM osmm_itn.roadrouteinformation) AS a;

-- Lookup between roadlinkinformation and roadlink on fid
-- Used to link in additional RRI to the network
CREATE OR REPLACE VIEW osmm_itn.roadlinkinformation_roadlink AS
SELECT fid AS roadlinkinformation_fid,
       replace(referencetoroadlink_href, '#', '') AS roadlink_fid
FROM osmm_itn.roadlinkinformation;

-- Each roadlink with associated roadname(s) and fid of road in case more info
-- is required
CREATE OR REPLACE VIEW osmm_itn.roads AS
SELECT array_to_string(road.roadname, ', ') AS roadname,
       road.fid AS road_fid,
       roadlink.*
FROM osmm_itn.roadlink AS roadlink
LEFT JOIN osmm_itn.road_roadlink AS road_roadlink ON (roadlink.fid = road_roadlink.roadlink_fid)
LEFT JOIN osmm_itn.road AS road ON (road_roadlink.road_fid = road.fid);
