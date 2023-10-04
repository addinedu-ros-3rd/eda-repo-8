SELECT tt1.region, (tt1.non_apt)*100, tt2.mix_rate
FROM (select t2.name_short as region, t1.non_apt 
		from (select region_id, 
					 (dandok + yeonlip + dasede + no_living + no_house) / (dandok + apart + yeonlip + dasede + no_living + no_house) as non_apt
				from home_house
				where region_name not in ('읍부', '면부', '동부')) t1
			join ko_region t2
		on t1.region_id = t2.id) tt1
join (select region_name, 
	   		 (mix_total / total)*100 as mix_rate
		from (select region_name,
	   				 (mix_recycle + mix_burn + mix_bury + mix_etc + recycle_recycle + recycle_burn + recycle_bury + recycle_etc + food_recycle + food_burn + food_bury + food_etc) as total,
	   				 (mix_recycle + mix_burn + mix_bury + mix_etc) as mix_total
			  from trash) t1) tt2
on tt1.region = tt2.region_name;