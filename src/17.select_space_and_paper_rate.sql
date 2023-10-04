select tt1.region, tt1.avg_indiv_meters, tt2.paper_rate
from (select t2.name_short as region, t1.avg_indiv_meters
		from (select region_id, region_name, avg(indiv_meters) as avg_indiv_meters
				from home_space
				group by region_id) t1
				join ko_region t2
				on t1.region_id = t2.id
		where t2.name_short is not null) tt1
join (select region_name, 
			 (paper / (mix_recycle + mix_burn + mix_bury + mix_etc + recycle_recycle + recycle_burn + recycle_bury + recycle_etc + food_recycle + food_burn + food_bury + food_etc))*100 as paper_rate
		from trash) tt2
on tt1.region = tt2.region_name;