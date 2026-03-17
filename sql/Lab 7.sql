
--1)
select *,row_number() over (partition by emp_id order by due_date) as rn
from tasks;

--2)
select *,rank() over (order by salary desc) as rnk from employees;


--3)
select * from ( select *,row_number() over (partition by emp_id order by due_date desc) as rn
    from tasks) 
where rn = 1;

--4)
select *, avg(salary) over (partition by dept_id) as avg_salary
from employees;

--5)
select *, count(*) over (partition by emp_id order by due_date) as running_count
from tasks;

--6)
select *,rank() over (order by salary desc) as rnk from employees;

--7)
select emp_id, count(*) as task_count
from tasks
group by emp_id
having count(*) > (
    select avg(task_count)
    from (
        select count(*) as task_count
        from tasks
        group by emp_id
    ) );


	------------------------------------------


	--1) 
	select *,dense_rank() over (order by priority desc) as rnk
from tasks;


--2)
select emp_id, count(*) as task_count from tasks
group by emp_id
order by task_count desc
limit 1;






--3)
alter table employees
add constraint fk_manager
foreign key (manager_id)
references employees(emp_id);

--4)
update employees
set manager_id = 3
where emp_id in (1,2);

update employees
set manager_id = 4
where emp_id in (5);


--5)
select e.emp_id, count(t.task_id) as emp_tasks
from employees e
join tasks t on e.emp_id = t.emp_id
group by e.emp_id, e.manager_id
having count(t.task_id) > (
    select count(*)
    from tasks t2
    where t2.emp_id = e.manager_id);
