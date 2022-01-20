select count(*) from
(
    select o.person_id from obs o
    inner join person p on p.person_id = o.person_id
    where o.concept_id = 5 
    and o.value_coded in (4008,4009,4010)
    and date(o.obs_datetime) between :startOfPeriod and :endOfPeriod
    and EXTRACT(YEAR FROM (FROM_DAYS(DATEDIFF(NOW(),p.birthdate)))) &gt; 5
    group by o.person_id
) from_health_facility
