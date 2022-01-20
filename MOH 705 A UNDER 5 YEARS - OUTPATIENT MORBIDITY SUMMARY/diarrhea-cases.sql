select count(person_id) from
(
select o.person_id, date_format(obs_datetime, '%d-%m-%Y') obs_date
from obs o
inner join person p on p.person_id = o.person_id
WHERE o.voided = 0
AND
  (o.concept_id = 5109 or o.concept_id = 2304 or o.concept_id = 160249)
AND DATE(o.obs_datetime) BETWEEN '2016-07-01' AND '2016-07-31'
AND o.value_coded IN (962,1003,1004,1215,1678,4029,4421,5018,148023,1228,4371,4131,4056,4034,1081,1228,117889)
AND EXTRACT(YEAR FROM (FROM_DAYS(DATEDIFF(NOW(),p.birthdate)))) &lt;= 5
group by o.person_id, obs_date
) diagnosis
