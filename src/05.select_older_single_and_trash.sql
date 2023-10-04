SELECT tt1.region, tt1.older_single_rate, tt2.mix_rate
FROM (SELECT kr.name_short as region, t1.older_single_rate
		FROM (SELECT hs.region_name,
			   		(teen.total / (sum(hs.people_m) + sum(hs.people_f)))*100 as older_single_rate
				from (select region_name, (people_m + people_f) as total
						from home_single
						where age_group in (40, 50)
						and region_name not like '%부'
						group by region_id) teen
				join home_single hs
				on teen.region_name = hs.region_name
				group by region_name) t1
		JOIN ko_region kr
		on t1.region_name = kr.name) tt1
join (select region_name, 
	   		 (mix_total / total)*100 as mix_rate
		from (select region_name,
	   				 (mix_recycle + mix_burn + mix_bury + mix_etc + recycle_recycle + recycle_burn + recycle_bury + recycle_etc + food_recycle + food_burn + food_bury + food_etc) as total,
	   				 (mix_recycle + mix_burn + mix_bury + mix_etc) as mix_total
			  from trash) t1) tt2
on tt1.region = tt2.region_name;