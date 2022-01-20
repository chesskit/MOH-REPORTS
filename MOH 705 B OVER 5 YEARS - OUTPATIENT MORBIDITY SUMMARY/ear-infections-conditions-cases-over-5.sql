-- Get count of new ear infection condition cases
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
  (1137,1345,1820,1822,1823,2116,4113,4115,4119,4122,4152,
    4154,4155,4156,4157,4160,4266,4295,4320,4343,4345,4402,4563,
    4917,4918,4919,4920,4563,119240,1473,1280)
AND EXTRACT(YEAR FROM (FROM_DAYS(DATEDIFF(NOW(),p.birthdate)))) &gt; 5
group by o.person_id, obs_date
) a;
