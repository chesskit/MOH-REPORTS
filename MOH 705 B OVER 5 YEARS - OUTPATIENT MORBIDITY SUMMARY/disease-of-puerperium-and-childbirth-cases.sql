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
AND o.value_coded IN (
    1014,1292,1411,1299,1294,2436,1016,1102,1319,1276,1405,1444,
    1001284,1151,1919,2492,4589,160210,123620,113279,130,1047,2522,
    120194,1177,1890,1353,4462,1804,1176
)
AND EXTRACT(YEAR FROM (FROM_DAYS(DATEDIFF(NOW(),p.birthdate)))) &gt; 5
group by o.person_id, obs_date
) a;