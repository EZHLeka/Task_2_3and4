CREATE TABLE  posts  (
	 id   int   NOT NULL PRIMARY KEY,	
	 name   varchar (50) NOT NULL
);

CREATE TABLE  departments  (
	 id   int   NOT NULL PRIMARY KEY,	
	 name   varchar (50) NOT NULL 
);
	
CREATE TABLE  experiences  (
	 id   int  NOT NULL PRIMARY KEY,	
	 name   varchar (50) NOT NULL
);
	

CREATE TABLE  persons  (
	 id   int   NOT NULL PRIMARY KEY,
	 surname   varchar (50) NOT NULL,
	 name   varchar (50) NULL,
	 patronymic   varchar (50) NULL,	
	 birth_date   date  NULL 
);	
	
CREATE TABLE  employees  (
	 id   int   NOT NULL PRIMARY KEY,
	 person_id   int  NOT NULL REFERENCES persons,
	 work_begin_date   date  NOT NULL,
	 work_end_date   date  NULL,
	 department_id   int  NOT NULL REFERENCES departments,
	 post_id   int  NOT NULL REFERENCES posts,
	 experience_id  int  NOT NULL REFERENCES experiences,
	 salary_level   numeric(18,2)  NOT NULL,	
	 is_access   BOOLEAN  NOT NULL DEFAULT TRUE
);
	
CREATE TABLE  kpi  (
	 id   int   NOT NULL PRIMARY KEY,	
	 name   varchar (50) NOT NULL 
);	
	
CREATE TABLE  kpi_employees  (
	 id   int   NOT NULL PRIMARY KEY,
	 employee_id   int  NOT NULL REFERENCES employees,	
	 kpi_id   int  NOT NULL REFERENCES kpi ,
	 kpi_date   date  NOT NULL,
	 kpi_quarter   int  NOT NULL GENERATED ALWAYS AS (date_part('QUARTER', kpi_date)) STORED
);	
	
	
	
