CREATE TABLE mmhg AS 
SELECT hadm_id AS id, valuenum AS mmhg FROM chartevents
WHERE valueuom=‘mmHg’;
/*create a table for each unit with HADM_ID in one column and the valuenum in the other column;
create table for each of the following units: 
mmHg as mmhg, % as perc, g/dl as gdl, k/ul as kul, units as units, 
mg/dl as mgdl, cm/h2o as cmh2o, l/min as lmin, mEq/L, kg as kg, expire as expire*/

CREATE TABLE avgmmhg AS
SELECT id, AVG(mmhg) AS avgmmhg FROM chartevents
GROUP BY id;
--create a table to average every unit except expire 

CREATE TABLE final_table AS 
SELECT a.id AS id, a.avgmmhg,b.avgperc,c.avggdl,d.avgkul,e.avgunits,f.avgmgdl,g.avgcmh2o,h.avglmin,i.avgmeql,j.avgkg,k.expire 
FROM avgmmhg a FULL JOIN avgperc b ON a.id=b.id FULL JOIN avggdl c ON a.id=c.id FULL JOIN avgkul d ON a.id=d.id 
FULL JOIN avgunits e ON a.id=e.id FULL JOIN avgmgdl f ON a.id=f.id FULL JOIN avgcmh2o g ON a.id=g.id 
FULL JOIN avglmin h ON a.id=h.id FULL JOIN avgmeql i ON a.id=i.id FULL JOIN avgkd j ON a.id=j.id FULL JOIN expire k ON a.id=k.id;
--full join all the tables together to create a table with a column for each unit and a row for each HADM_ID