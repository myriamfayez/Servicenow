--1)
with avg_sal as (select dept_id, avg(salary) as avg_salary from employees
    group by dept_id)
select * from avg_sal where avg_salary > 4000;



--2)
 select emp_name from employees

except
select e.emp_name from employees e
join departments d on e.dept_id = d.dept_id
where d.dept_name = 'IT';




--3)

select e.emp_name from employees e
join works_on w on e.emp_id = w.emp_id
join projects p on w.project_id = p.project_id
where p.project_name = 'Sales'

intersect
select e.emp_name from employees e
join works_on w on e.emp_id = w.emp_id
join projects p on w.project_id = p.project_id
where p.project_name = 'Marketing';






--4)

begin;

update employees
set salary = 6000
where emp_id = 5;

update employees
set dept_id = 3
where emp_id = 5;

commit;



rollback;


--5)

select e.emp_name from employees e
join departments d on e.dept_id = d.dept_id
where d.dept_name = 'Sales';





create table tasks (
    task_id serial primary key,
    emp_id int,
    task_name varchar(100),
    priority varchar(20),
    due_date date,
    status varchar(20),
    foreign key (emp_id) references employees(emp_id));



insert into tasks (emp_id, task_name, priority, due_date, status)
values
(1, 'servicenow', 'high', current_date, 'pending'),
(2, 'sql', 'medium', current_date + 1, 'completed')


--6)
select e.emp_name from employees e
join tasks t on e.emp_id = t.emp_id
where t.priority = 'High';

--7)
select e.emp_name from employees e
join tasks t on e.emp_id = t.emp_id
where t.due_date = current_date;

--8)
select emp_name from employees
where emp_id not in (
    select emp_id from tasks
    where status = 'Completed');



--------------------------------------------------------------------

--1)
select e.emp_name from employees e
join tasks t on e.emp_id = t.emp_id
group by e.emp_name
having count(t.task_id) > 2;

--2)
select * from tasks
where due_date >
(
    select max(due_date) from tasks
    where status = 'completed');




--3)
select distinct e.emp_name from employees e
join tasks t on e.emp_id = t.emp_id
where t.priority = 'high';


--4)
select distinct e.emp_name from employees e
join tasks t on e.emp_id = t.emp_id
where t.status = 'completed';

	
