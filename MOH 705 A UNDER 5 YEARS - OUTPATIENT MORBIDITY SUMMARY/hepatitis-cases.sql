-- Get count of new cases of hepatitis
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
  (1005,1006,1007,1008,1505,1506,1746,1747,1748,2524,2525,
    2526,2527,2528,2587,4436,145131,160143)
AND EXTRACT(YEAR FROM (FROM_DAYS(DATEDIFF(NOW(),p.birthdate)))) &lt;= 5
group by o.person_id, obs_date
) a;
