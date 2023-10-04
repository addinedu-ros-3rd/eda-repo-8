select tt1.region, tt1.young_rate, tt2.plastic_rate
from (select t2.name_short as region, t1.young_rate
		from (select home_young.region_name, (home_young.young / home_total.total)*100 as young_rate
				from (select region_name,
							 (sum(member_one) + sum(member_two) + sum(member_three) + sum(member_four) + sum(member_five) + sum(member_six) + sum(member_seven)) as young
						from home_age_and_members
						where age_group in (20, 30) and region_name not like '%부'
						group by region_name) home_young
				join (select region_name,
							  (sum(member_one) + sum(member_two) + sum(member_three) + sum(member_four) + sum(member_five) + sum(member_six) + sum(member_seven)) as total
						from home_age_and_members
						where region_name not like '%부'
						group by region_name) home_total
				on home_young.region_name = home_total.region_name) t1
		join ko_region t2
		on t1.region_name = t2.name) tt1
join (select region_name, 
			 (plastic / (mix_recycle + mix_burn + mix_bury + mix_etc + recycle_recycle + recycle_burn + recycle_bury + recycle_etc + food_recycle + food_burn + food_bury + food_etc))*100 as plastic_rate
		from trash) tt2
on tt1.region = tt2.region_name;