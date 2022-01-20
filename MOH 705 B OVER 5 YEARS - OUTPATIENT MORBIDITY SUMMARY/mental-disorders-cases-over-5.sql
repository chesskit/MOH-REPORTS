-- Get count of new medical disorder cases
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
AND o.value_coded IN (119537,2044,1845,3659,3660,4586,134337,160200,1096,1114,4564,160197,1111,1104,4507,113155,11935,1915,1360,1136,113881)
AND EXTRACT(YEAR FROM (FROM_DAYS(DATEDIFF(NOW(),p.birthdate)))) &gt; 5
group by o.person_id, obs_date
) a;
