Select*from world_life_expectancyworld_life_expectancy;


Select country,MIN(`Life Expectancy`),MAX(`Life Expectancy`),
round(Max(`Life Expectancy`)-Min(`Life Expectancy`),1) as Life_Increase_15_Years
from world_life_expectancy
group by country 
having min(`Life expectancy`)<>0
and max(`Life expectancy`)<>0
order by Life_Increase_15_Years ASC;

Select year,round(avg(`Life Expectancy`),2)
from world_life_expectancy
where `Life Expectancy`<>0
and `Life Expectancy`<>0
group by year
order by year;

select*from world_life_expectancy;

Select country,round(avg(`Life Expectancy`),1) as Life_Exp,round(avg(GDP),1) as GDP
from world_life_expectancy
group by country
having Life_Exp>0
AND GDP>0
Order by GDP ASC;

Select
sum(case
    when GDP>= 1500 THEN 1
    ELSE 0
END) High_GDP_Count
from world_life_expectancy;

Select Status,Round(Avg(`Life Expectancy`),1)
from world_life_expectancy group by Status;

Select status,count(Distinct country),Round(Avg(`Life Expectancy`),1)
from world_life_expectancy group by Status;

Select country,round(avg(`Life Expectancy`),1) as Life_Exp,round(avg(BMI),1) as BMI
from world_life_expectancy
group by country
having Life_Exp>0
AND BMI>0
Order by BMI DESC;

SELECT Country,Year,`Life Expectancy`,`Adult Mortality`,
Sum(`Adult Mortality`) over(partition by country order by year) as Rolling_Total
from world_life_expectancy;