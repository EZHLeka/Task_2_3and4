INSERT INTO public.employees(person_id, work_begin_date,  department_id, post_id, experience_id, salary_level)
-- руководители
select id, 						   
		cast (timestamp '2022-01-10 20:00:00' +
       random() * (timestamp '2020-01-20 20:00:00' -
                   timestamp '2022-01-10 10:00:00')as date),					   
ROW_NUMBER() OVER(PARTITION BY 1),1,4, 25 					   
from public.persons where id between 1 and 4

-- по отделам и должностям
union all
select id, 						   
		cast (timestamp '2022-01-10 20:00:00' +
       random() * (timestamp '2020-01-20 20:00:00' -
                   timestamp '2022-01-10 10:00:00')as date),					   
1, 3, 5, 12 					   
from public.persons where id between 5 and 6
union all
select id, 						   
		cast (timestamp '2022-01-10 20:00:00' +
       random() * (timestamp '2020-01-20 20:00:00' -
                   timestamp '2022-01-10 10:00:00')as date),					   
1, 2, 5, 8 					   
from public.persons where id between 7 and 7

--zakupki
union all
select id, 						   
		cast (timestamp '2022-01-10 20:00:00' +
       random() * (timestamp '2020-01-20 20:00:00' -
                   timestamp '2022-01-10 10:00:00')as date),					   
2, 6 ,cast(random() * 2 + 1 as integer), cast(random() * 20 + 10 as integer)					   
from public.persons where id between 8 and 18

--it
union all
select id, 						   
		cast (timestamp '2022-01-10 20:00:00' +
       random() * (timestamp '2020-01-20 20:00:00' -
                   timestamp '2022-01-10 10:00:00')as date),					   
3, 4 ,cast(random() * 3 + 1 as integer), cast(random() * 30 + 10 as integer)					   
from public.persons where id between 19 and 37

--analitic
union all
select id, 						   
		cast (timestamp '2022-01-10 20:00:00' +
       random() * (timestamp '2020-01-20 20:00:00' -
                   timestamp '2022-01-10 10:00:00')as date),					   
4, 5 ,cast(random() * 3 + 1 as integer), cast(random() * 25 + 10 as integer)					   
from public.persons where id between 38 and 51

update public.employees
set salary_level = salary_level * experience_id









	