INSERT INTO public.departments(name)
select 'Отдел бухгатерского учета'
union all
select 'Отдел закупок'
union all
select 'Отдел IT'
union all
select 'Отдел интеллектуального анализа данных';

INSERT INTO public.posts(name)
select 'Руководитель отдела'
union all
select 'Документовед'
union all
select 'Бухгалтер'
union all
select 'Программист'
union all
select 'Аналитик';

INSERT INTO public.experiences(name)
select 'jun'
union all
select 'middle'
union all
select 'senior'
union all
select 'lead'
union all
select 'none';

INSERT INTO public.kpi(name)
select 'A'
union all
select 'B'
union all
select 'C'
union all
select 'D'
union all
select 'E';


	