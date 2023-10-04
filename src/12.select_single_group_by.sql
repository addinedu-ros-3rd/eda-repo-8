-- 지역별 전체 1인 가구수
select tt2.name_short as region, tt1.age_group, tt1.age_rate
from (select t1.region_name,
			   t2.age_group,
			   (t2.age_numbers / t1. numbers)*100 as age_rate 
		from (select region_name,
						(sum(people_m) + sum(people_f)) as numbers
				from home_single
				where region_name not like '%부'
				group by region_name) t1
		join (select region_name,
					   age_group,
					   (sum(people_m) + sum(people_f)) as age_numbers
				from home_single
				where region_name not like '%부' and age_group != 10
				group by region_name, age_group) t2
		on t1.region_name = t2.region_name) tt1
join ko_region tt2
on tt1.region_name = tt2.name;