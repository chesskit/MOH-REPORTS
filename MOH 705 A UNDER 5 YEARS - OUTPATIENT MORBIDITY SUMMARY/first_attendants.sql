SELECT COUNT(*)
FROM (
SELECT patient_id, MIN(encounter_datetime) first_encounter_date
FROM encounter e
INNER JOIN person p
ON e.patient_id=p.person_id
AND EXTRACT(YEAR FROM (FROM_DAYS(DATEDIFF(NOW(),p.birthdate)))) &lt;= 5

WHERE encounter_type=9
GROUP BY patient_id

HAVING MIN(encounter_datetime) BETWEEN '2016-07-01' AND '2016-07-31'
) AS first_attendants;