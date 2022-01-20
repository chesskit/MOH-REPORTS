-- Get count of new confirmed malaria cases
select count(person_id)
from
(
select o.person_id, date_format(obs_datetime, '%d-%m-%Y') obs_date
from obs o
inner join person p on p.person_id = o.person_id
WHERE o.voided = 0
AND
  (o.concept_id=5109)
AND DATE(o.obs_datetime) BETWEEN :startOfPeriod AND :endOfPeriod
AND o.value_coded IN
  (160154,160155,160152,160150,160148,116128,4516,4515,4492,4055,
    4314,4293,4290,4267,705,4055,4054,4041,4027,2088,1041,708)
AND EXTRACT(YEAR FROM (FROM_DAYS(DATEDIFF(NOW(),p.birthdate)))) &gt; 5
group by o.person_id, obs_date
) a;
