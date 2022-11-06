SELECT * FROM public.experiences;
SELECT * FROM public.kpi;	
SELECT * FROM public.departments;
SELECT * FROM public.posts;
SELECT * FROM public.persons;
SELECT * FROM public.employees;
SELECT * FROM public.kpi_employees;
--Уникальный номер сотрудника, его ФИО и стаж работы – для всех сотрудников компании
SELECT em.id, ps.surname ||''||ps.name ||''|| ps.patronymic  as FIO, 
(DATE_PART('year',CURRENT_DATE) - DATE_PART('year', em.work_begin_date)) * 12 + 
DATE_PART('month',CURRENT_DATE) - DATE_PART('month', em.work_begin_date)  as stage_month
FROM persons as ps
inner join employees em on ps.id = em.person_id; 
--Уникальный номер сотрудника, его ФИО и стаж работы – только первых 3-х сотрудников
SELECT em.id, ps.surname ||''||ps.name ||''|| ps.patronymic  as FIO, 
(DATE_PART('year',CURRENT_DATE) - DATE_PART('year', em.work_begin_date)) * 12 + 
DATE_PART('month',CURRENT_DATE) - DATE_PART('month', em.work_begin_date)  as stage_month
FROM persons as ps
inner join employees em on ps.id = em.person_id
order by em.id
limit 3;
--Уникальный номер сотрудников - "Программист"
SELECT em.id, ps.surname ||' '||ps.name ||' '|| ps.patronymic  as FIO, pt.name 
FROM persons as ps
inner join employees em on ps.id = em.person_id
inner join posts pt on em.post_id = pt.id
where pt.name LIKE '%Програм%';
--Выведите номера сотрудников, которые хотя бы за 1 квартал получили оценку D или E
SELECT distinct em.id, ps.surname ||' '||ps.name ||' '|| ps.patronymic  as FIO, kpi.name 
FROM persons as ps
inner join employees em on ps.id = em.person_id
inner join kpi_employees ke on em.id = ke.employee_id
inner join kpi on kpi.id = ke.kpi_id
where kpi_id in (4,5) and ke.kpi_quarter = 1
order by em.id;
--Выведите самую высокую зарплату в компании.
SELECT max (em.salary_level) 
FROM employees em 
--* Выведите название самого крупного отдела
SELECT d.name, count(e.id)
FROM public.departments d
inner join public.employees e on d.id  = e.department_id 
group by d.name
order by count(e.id) desc
limit 1;
-- * Выведите номера сотрудников от самых опытных до вновь прибывших
SELECT em.id, ps.surname ||' '||ps.name ||' '|| ps.patronymic  as FIO, em.work_begin_date 
FROM persons as ps
inner join employees em on ps.id = em.person_id
order by em.work_begin_date;
--* Рассчитайте среднюю зарплату для каждого уровня сотрудников
SELECT ex.name, round(avg(em.salary_level),2)
FROM employees em
inner join experiences ex on em.experience_id = ex.id
group by ex.name,ex.id
order by ex.id;
--* Добавьте столбец с информацией о коэффициенте годовой премии к основной таблице.
ALTER TABLE public.employees
  ADD COLUMN rate Numeric(18,2) NOT NULL DEFAULT 1;

update employees
set rate = kpi_em.kk 
from employees em
inner join 
	(SELECT kem.employee_id, 
			case when kem.employee_id is not null then
						sum(case 	when kpi_quarter = 1 then 0.2
									when kpi_quarter = 2 then 0.1
									when kpi_quarter = 3 then 0
									when kpi_quarter = 4 then -0.1
									when kpi_quarter = 5 then -0.2		
								else 1 end) + 1
			else 1 end as kk				
	FROM kpi_employees kem
	where DATE_PART('year',kpi_date) = DATE_PART('year',CURRENT_DATE) - 1 
	group by kem.employee_id
	) as  kpi_em on em.id = kpi_em.employee_id
where employees.id = em.id;









