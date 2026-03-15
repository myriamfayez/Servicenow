select * from employees e where 
hire_date = (
    select max(hire_date)
    from employees
    where dept_id = e.dept_id);


select * from employees natural join departments;

create table works_on (
    emp_id int,
    project_id int,
    primary key (emp_id, project_id),
    foreign key (emp_id) references employees(emp_id),
    foreign key (project_id) references projects(project_id)
);


insert into works_on (emp_id, project_id)
values
(1,1),
(2,1);



select p.project_name, count(w.emp_id) as employees_count from projects p
left join works_on w on p.project_id = w.project_id
group by p.project_name;

select e1.emp_name, e2.emp_name, e1.salary from employees e1
join employees e2 on e1.salary = e2.salary
and e1.emp_id < e2.emp_id;

select p.project_name, e.emp_name from projects p
join works_on w on p.project_id = w.project_id
join employees e on w.emp_id = e.emp_id;


select e.emp_name, d.dept_name from employees e
 join departments d on e.dept_id = d.dept_id;


select d.dept_name, e.emp_name from departments d
join employees e on d.dept_id = e.dept_id
group by d.dept_name, e.emp_name
limit 1;


select dept_name,
(
    select avg(salary)
    from employees e
    where e.dept_id = d.dept_id
) as avg_salary
from departments d;


select * from employees where hire_date in (
    select hire_date
    from employees
    group by hire_date
    having count(*) > 1);


	select * from employees where salary > (
    select avg(salary)
    from employees);
