SELECT COUNT(*) FROM 
encounter e
INNER JOIN person p ON e.patient_id=p.person_id
AND EXTRACT(YEAR FROM (FROM_DAYS(DATEDIFF(NOW(),p.birthdate)))) &lt;= 5

WHERE CONCAT(patient_id, '-', encounter_id) NOT IN (
SELECT CONCAT(patient_id, '-', MIN(encounter_id))first_encounter_id
FROM encounter e

WHERE encounter_type=9
GROUP BY patient_id
)
AND encounter_datetime BETWEEN '2016-07-01' AND '2016-07-31'
AND encounter_type=9;