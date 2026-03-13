create table departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

select * from departments

--EXISTS MEANS LW TRUE HY722 EL SELECT EL FO2 MSH BYSHT8LO SHO8L B3D
SELECT DEPT_NAME FROM DEPARTMENTS WHERE EXISTS(
SELECT 1 FROM DEPARTMENTS WHERE DEPT_ID=3
)
create table employees (
    emp_id serial primary key,
    emp_name varchar(100) not null,
    salary numeric(10,2) check (salary > 0),
    dept_id int,
    hire_date date
);

select
    emp_name,
    salary,
    case
        when salary >= 10000 then 'high'
        when salary >= 5000 then 'medium'
        else 'low'
    end as salary_level
from employees;

select * from employees

alter table employees
add constraint fk_dept
foreign key (dept_id)
references departments(dept_id)
on delete cascade
on update cascade


create table projects (
    project_id serial primary key,
    project_name varchar(100) not null,
    dept_id int
);


alter table projects
add constraint fk_project_dept
foreign key (dept_id)
references departments(dept_id)
on delete set null
on update cascade;

insert into departments (dept_name)
values
('hr'),
('it'),
('finance');

insert into employees (emp_name, salary, dept_id, hire_date)
values
('ahmed', 5000, 1, '2024-01-10'),
('mona', 6500, 2, '2023-03-15'),
('omar', 7200, 2, '2022-06-20'),
('sara', 5500, 3, '2024-02-01'),
('ali', 4800, 1, '2023-11-05');


insert into projects (project_name, dept_id)
values
('SERVICENOW', 2),
('CRM', 1),
('WEBSITE', 3);

update employees
set salary = salary + 1000
where emp_id = 1;


update employees
set dept_id = 3
where emp_id = 2;

alter table employees
add column email varchar(100) unique;


alter table departments
add column phone varchar(20);


alter table employees
alter column salary set not null;

select * from  employees

update departments
set dept_id = 10
where dept_id = 1;

select * from  departments
