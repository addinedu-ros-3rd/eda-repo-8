select '전국' as region, age_group, 
	   ((sum(people_m) + sum(people_f)) / (select (sum(people_m) + sum(people_f)) as all_total
											from home_single
											where region_name like '%부' and age_group != 10))*100 as age_rate
from home_single
where region_name like '%부' and age_group != 10
group by age_group;