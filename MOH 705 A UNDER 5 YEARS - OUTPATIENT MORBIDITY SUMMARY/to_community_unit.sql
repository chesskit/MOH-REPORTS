select count(*) from
(
    select o.person_id, date_format(o.obs_datetime, '%d-%m-%Y') obs_date from obs o
    inner join person p on p.person_id = o.person_id
    where o.concept_id = 3004 
    and o.value_coded = 100126128
    and date(o.obs_datetime) between :startOfPeriod and :endOfPeriod
    and EXTRACT(YEAR FROM (FROM_DAYS(DATEDIFF(NOW(),p.birthdate)))) &lt;= 5
    group by o.person_id, obs_date
) to_community_units
