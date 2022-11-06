-- INSERT INTO public.kpi_employees(employee_id, kpi_id, kpi_date, kpi_quarter)

with recursive dates as (
    select 
           '2020-03-31'::timestamp as dt1, 
           '2022-12-31'::timestamp as dt2,
           interval '1 month' as interval
),
pr AS(
    select
        3 as i,
        (select dt1 from dates) as dt
    union

    select 
        i+3 as i, 
        ( (select dt1 from dates) + ( select interval from dates)*i)::timestamp as dt
    from pr
    where ( ((select dt1 from dates) + (select interval from dates)*i)::timestamp) <=(select dt2 from dates)
)

--select dt as gs from pr;

INSERT INTO public.kpi_employees(employee_id, kpi_id, kpi_date)
SELECT id, cast(random() * 4 + 1 as integer), cast (dt as date)
FROM public.employees cross join pr 
where work_begin_date <= cast (dt as date);
	