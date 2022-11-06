-- ***По итогам индексации отдел финансов хочет получить следующий отчет:
SELECT dep.id, dep.name as "Название отдела",
mg.FIO as "Фамилия руководителя",
count(em.id)  as "Количество сотрудников",
round(cast (avg((DATE_PART('year',CURRENT_DATE) - DATE_PART('year', em.work_begin_date)) * 12 + 
DATE_PART('month',CURRENT_DATE) - DATE_PART('month', em.work_begin_date)) as numeric(18,2)) , 0) as "Средний стаж в мес.",
round(avg (em.salary_level) ,2) as "Средний уровень зарплаты",
sum (case when em.experience_id = 1  then 1 else 0 end) as "Количество сотрудников уровня junior",
sum (case when em.experience_id = 2  then 1 else 0 end) as "Количество сотрудников уровня middle",
sum (case when em.experience_id = 3  then 1 else 0 end) as "Количество сотрудников уровня senior",
sum (case when em.experience_id = 4  then 1 else 0 end) as "Количество сотрудников уровня lead_",
sum (case when em.experience_id = 5  then 1 else 0 end) as "Количество сотрудников уровня none_",
sum (se1.salary)  as "Общий размер оплаты труда всех сотр. до индексации",
sum (se2.salary)  as "Общий размер оплаты труда всех сотр. после индексации",
ke.aa as "Общее количество оценок А",
ke.bb as "Общее количество оценок B",
ke.cc as "Общее количество оценок C_",
ke.dd as "Общее количество оценок D",
ke.ee as "Общее количество оценок Е", 
round(avg(em.rate),2) as "Средний показатель коэффициента премии",
sum(se2.salary * em.rate) as "Общий размер премии",
sum(se1.salary + (se1.salary * em.rate )) as "Общая сумма зарплат(+ премии) до индексации",
sum(se2.salary + (se2.salary * em.rate )) as "Общая сумма зарплат(+ премии) после индексации",
round(100*(sum(se2.salary + (se2.salary * em.rate )) - sum(se1.salary + (se1.salary * em.rate ))) / sum(se2.salary + (se2.salary * em.rate )),2)    as "Разницу в %"
FROM employees em
inner join departments dep on em.department_id = dep.id
inner join
		(select p.surname ||' '||p.name ||' '|| p.patronymic as FIO, e_m.department_id
		 from employees e_m  
		 inner join persons p on e_m.person_id = p.id 
		 where e_m.post_id = 1
		) as mg on mg.department_id = dep.id
left join salary_employees se1 on em.id = se1.employee_id and  se1.salary_date = to_date('2022-01-01' , 'YYYY-MM-DD')
left join salary_employees se2 on em.id = se2.employee_id and  se2.salary_date = to_date('2022-02-01' , 'YYYY-MM-DD')
left join
		(select department_id,
		sum (case when kpi_e.kpi_id = 1  then 1 else 0 end) as aa,
		sum (case when kpi_e.kpi_id = 2  then 1 else 0 end) as bb,
		sum (case when kpi_e.kpi_id = 3  then 1 else 0 end) as cc,
		sum (case when kpi_e.kpi_id = 4  then 1 else 0 end) as dd,
		sum (case when kpi_e.kpi_id = 5  then 1 else 0 end) as ee
		FROM employees e
		left join kpi_employees kpi_e on e.id = kpi_e.employee_id 
		and DATE_PART('year',kpi_e.kpi_date) = (DATE_PART('year',CURRENT_DATE) - 1)
		group by department_id) as ke on ke.department_id = dep.id
group by dep.id, em.department_id, dep.name, mg.FIO, ke.aa, ke.bb, ke.cc, ke.dd, ke.ee