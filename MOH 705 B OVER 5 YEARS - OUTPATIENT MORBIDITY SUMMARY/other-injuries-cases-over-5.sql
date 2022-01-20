-- get count of other injuries cases
select count(person_id)
from
(
select o.person_id, date_format(obs_datetime, '%d-%m-%Y') obs_date
from obs o
inner join person p on p.person_id = o.person_id
WHERE o.voided = 0
AND o.concept_id=5109 
AND
	(o.concept_id=5109 or o.concept_id = 2304 or o.concept_id = 160249)
AND DATE(o.obs_datetime) BETWEEN :startOfPeriod AND :endOfPeriod
AND o.value_coded IN (1043,1061,1077,1084,1265,1267,1452,1767,1770,2341,2343,3896,112561,125343,125379,158995,160175,1490,160186,160187,160188)
AND EXTRACT(YEAR FROM (FROM_DAYS(DATEDIFF(NOW(),p.birthdate)))) &gt; 5
group by o.person_id, obs_date
) a;
