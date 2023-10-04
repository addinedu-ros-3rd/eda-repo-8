select tt1.region, tt1.single_rate, tt2.mix_rate
from (select t2.name_short as region, (single / total)*100 as single_rate
		from (select hs.region_name as reg, 
	   				 sum(people_m) + sum(people_f) as single,
	   				 (dandok + apart + yeonlip + dasede + no_living + no_house) as total
				from home_single hs
				join home_house hh
				on hs.region_id = hh.region_id
				where hs.region_name not in ('읍부', '면부', '동부')
				group by hs.region_id) as t1
		join ko_region t2
		on t1.reg = t2.name) tt1
join (select region_name, 
	   		 (mix_total / total)*100 as mix_rate
		from (select region_name,
	   				 (mix_recycle + mix_burn + mix_bury + mix_etc + recycle_recycle + recycle_burn + recycle_bury + recycle_etc + food_recycle + food_burn + food_bury + food_etc) as total,
	   				 (mix_recycle + mix_burn + mix_bury + mix_etc) as mix_total
			  from trash) t1) tt2
on tt1.region = tt2.region_name;