select tt1.region, tt1.two_gen_rate*100, tt2.paper_rate*100
from (select t2.name_short as region, t1.two_gen_rate
		from (select region_name as region,
					 two_gen / (one_gen + two_gen + three_gen + more_than_four_gen + single_home + no_blood) as two_gen_rate
				from home_generation
				where region_name  not like '%부') t1
		join ko_region t2
		on t1.region = t2.name) tt1
join (select region_name,
	   			paper / (mix_recycle + mix_burn + mix_bury + mix_etc + recycle_recycle + recycle_burn + recycle_bury + recycle_etc + food_recycle + food_burn + food_bury + food_etc) as paper_rate
		from trash) tt2
on tt1.region = tt2.region_name;