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



select emp_name
from employees
where emp_name similar to '(a|m)%';


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


alter table employees
add column dept_name varchar(100);

insert into employees (emp_name, salary, dept_id, dept_name, hire_date)
values
('ahmed ali', 9000, 1, 'it', '2022-01-10'),
('mona hassan', 5000, 2, 'hr', '2021-05-15'),
('omar saad', 3000, 3, 'finance', '2023-03-20'),
('sara mahmoud', 7000, 1, 'it', '2022-07-12'),
('youssef adel', 8500, 2, 'hr', '2020-11-01');

select *
from employees
where dept_name = 'it';

select *
from employees
where salary between 4000 and 9000;

select *
from employees
where emp_name similar to 'a%';

select *
from employees
where dept_name is null;


select *
from employees
where dept_id in (1,2,3);

select
emp_name,
salary,
case
when salary > 8000 then 'high'
when salary between 4000 and 8000 then 'medium'
else 'low'
end as salary_level
from employees;

select * from projects


alter table projects
add column emp_id int;


update projects
set emp_id = 1
where project_id = 1;

update projects
set emp_id = 2
where project_id = 2;

select *
from employees e
where exists (
select 1
from projects p
where p.emp_id = e.emp_id
);

select *
from employees
where salary > any (
select salary
from employees
where dept_id = 2
);

select *
from employees
where salary = (
select max(salary)
from employees
);

create table high_salary_employees as
select *
from employees
where salary > 8000;


delete from employees e
where not exists (
select 1
from projects p
where p.emp_id = e.emp_id
);


select *
from departments d
where not exists (
select 1
from employees e
where e.dept_id = d.dept_id
);


alter table departments
add column location varchar(100);


insert into departments (dept_name, location)
values

('marketing','alex'),
('sales','giza');

select distinct location
from departments;


select
emp_name,
salary,
salary * 1.10 as salary_after_bonus
from employees;


select
upper(emp_name),
lower(emp_name),
initcap(emp_name)
from employees;

select
trim(emp_name),
ltrim(emp_name),
rtrim(emp_name)
from employees;

select
concat(emp_name,' ',salary) as name_salary
from employees;


select
substring(emp_name from 1 for 3)
from employees;

select
position('a' in emp_name)
from employees;

select
replace(emp_name,'ahmed','ahmad')
from employees;

select
cast(salary as integer)
from employees;

select
salary::int
from employees;