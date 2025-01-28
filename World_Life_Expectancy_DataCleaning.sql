SELECT * FROM world_life_expectancy;

-- Select country,year,concat(country,year),count(concat(country,year))
-- from world_life_expectancy group by country,year,concat(country,year)
-- having count(concat(country,year))>1;

select* from(select row_id,concat(country,year),row_number() over(partition by concat(country,year) order by concat(country,year)) as row_num
from world_life_expectancy) as row_table where row_num>1;

Delete from world_life_expectancy where row_id in(select row_id from(select row_id,concat(country,year),row_number() over(partition by concat(country,year) order by concat(country,year)) as row_num
from world_life_expectancy) as row_table where row_num>1);


update world_life_expectancy t1
join world_life_expectancy t2
on t1.country=t2.country
set t1.Status='Developing'
where
t1.Status=''
and t2.status <>''
and t2.Status<>'Developing';

update world_life_expectancy t1
join world_life_expectancy t2
on t1.country=t2.country
set t1.status='Developed'
where
t1.status=''
and t2.status<>''
and t2.status='Developed';

-- Select t1.country,t1.year, t1.[Life expectancy] ,t2.country,t2.year,t2.[Life expectancy],
-- t3.country,t3.year,t3.[Life expectancy],
-- ((t2.[Life expectancy] + t3.[Life expectancy])/2,1)as avg
-- from world_life_expectancy t1
-- Join world_life_expectancy t2
-- on t1.country=t2.country
-- and t1.year=t2.year-1
-- JOIN world_life_expectancy t3
-- on t1.country=t3.country and
-- t1.year=t3.year+1;

SELECT 
    t1.country, t1.year, t1.`Life expectancy`, 
    t2.country, t2.year, t2.`Life expectancy`,
    t3.country, t3.year, t3.`Life expectancy`,
    ROUND((t2.`Life expectancy` + t3.`Life expectancy`) / 2, 1) AS avg
FROM 
    world_life_expectancy t1
JOIN 
    world_life_expectancy t2
    ON t1.country = t2.country AND t1.year = t2.year - 1
JOIN 
    world_life_expectancy t3
    ON t1.country = t3.country AND t1.year = t3.year + 1
    where t1.`Life expectancy`=' ';

update world_life_expectancy t1
join world_life_expectancy t2
on t1.country=t2.country
and t1.year=t2.year-1
join world_life_expectancy t3
on t1.country=t3.country
and t1.year=t3.year+1
 set t1.`Life expectancy`=ROUND((t2.`Life expectancy` + t3.`Life expectancy`) / 2, 1)
 where t1.`Life expectancy`=' ';