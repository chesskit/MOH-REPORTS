-- Get count of new dental disorder cases
select count(person_id)
from
(
select o.person_id, date_format(obs_datetime, '%d-%m-%Y') obs_date
from obs o
inner join person p on p.person_id = o.person_id
WHERE o.voided = 0
AND
  (o.concept_id=5109 or o.concept_id = 2304 or o.concept_id = 160249)
AND DATE(o.obs_datetime) BETWEEN :startOfPeriod AND :endOfPeriod
AND o.value_coded IN 
  (1048,1531,1533,1599,1610,1620,2755,3113,4362,4451,119558,119558,1044,1534,1602,1646,160139,1198,1199,1642,4541,1643,1663,4174,1595,1597,1598)
AND EXTRACT(YEAR FROM (FROM_DAYS(DATEDIFF(NOW(),p.birthdate)))) &gt; 5
group by o.person_id, obs_date
) a;
