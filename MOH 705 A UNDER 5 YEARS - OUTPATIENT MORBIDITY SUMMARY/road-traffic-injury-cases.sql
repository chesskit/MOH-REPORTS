-- Get count of new road traffic injury cases
SELECT COUNT(*)

FROM obs o
INNER JOIN person p ON o.person_id=p.person_id
AND EXTRACT(YEAR FROM (FROM_DAYS(DATEDIFF(NOW(),p.birthdate)))) &lt;= 5
AND DATE(death_date)=DATE(obs_datetime)
INNER JOIN encounter e ON e.encounter_id=o.encounter_id
AND (e.encounter_type=6 OR e.encounter_type=9)

WHERE concept_id=11
AND value_coded=1028
AND obs_datetime BETWEEN '2016-07-01' AND '2016-08-31'
