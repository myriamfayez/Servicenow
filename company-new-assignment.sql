
select *
from employees
where salary between 4000 and 9000;

select *
from employees
where emp_name similar to 'a%';

select *
from employees
where dept_id is null;

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

select e.emp_name, d.dept_name
from employees e
join departments d
on e.dept_id = d.dept_id;

select d.dept_name, count(e.emp_id)
from departments d
join employees e
on d.dept_id = e.dept_id
group by d.dept_name
having count(e.emp_id) > 1;

select e.emp_name, e.salary, d.dept_name
from employees e
join departments d
on e.dept_id = d.dept_id
order by e.salary desc
limit 3;

select d.dept_name, e.emp_name
from departments d
left join employees e
on d.dept_id = e.dept_id;



alter table projects
add column hours_worked int;




update projects
set hours_worked = 120
where project_id = 1;

update projects
set hours_worked = 90
where project_id = 2;

update projects
set hours_worked = 150
where project_id = 3;


select project_name, sum(hours_worked) as total_hours
from projects
group by project_name
order by total_hours desc;

select d.dept_name, avg(e.salary)
from departments d
join employees e
on d.dept_id = e.dept_id
group by d.dept_name
having avg(e.salary) > 6000;