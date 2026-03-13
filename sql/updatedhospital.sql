create table doctors (
    doctor_id serial primary key,
    first_name varchar(50),
    middle_name varchar(50),
    last_name varchar(50),
    specialization varchar(100),
    qualification varchar(100)
);

alter table doctors
add column salary numeric(10,2) check (salary > 0);

create table patients (
    patient_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    dob date,
    locality varchar(100),
    city varchar(100),
    doctor_id int,
    foreign key (doctor_id)
    references doctors(doctor_id)
    on delete cascade
    on update cascade
);

create table medicines (
    code serial primary key,
    medicine_name varchar(100),
    price numeric,
    quantity int
);

create table patient_medicine (
    bill_id serial primary key,
    patient_id int,
    medicine_code int,
    quantity int,
    bill_date date,
    foreign key (patient_id) references patients(patient_id),
    foreign key (medicine_code) references medicines(code)
);

insert into doctors (first_name,middle_name,last_name,specialization,qualification)
values
('ali','m','hassan','heart','master'),
('sara','a','mahmoud','skin','master'),
('omar','k','fathy','kids','master');

insert into patients (first_name,last_name,dob,locality,city,doctor_id)
values
('ahmed','ali','1995-02-10','nasr city','cairo',1),
('mona','hassan','1998-06-12','maadi','cairo',2),
('youssef','adel','2000-01-05','dokki','giza',1),
('salma','nabil','1997-08-15','heliopolis','cairo',3),
('karim','samy','1999-03-20','zamalek','cairo',2);

insert into medicines (medicine_name,price,quantity)
values
('panadol',20,100),
('augmanteen',50,40),
('brufen',30,60),
('insulin',120,20),
('aspirin',15,80);

insert into patient_medicine (patient_id,medicine_code,quantity,bill_date)
values
(1,1,2,'2026-03-01'),
(2,3,1,'2025-03-02'),
(3,2,3,'2025-03-03'),
(4,5,2,'2026-03-04'),
(5,4,1,'2026-03-05');

update medicines
set price = price + 10
where code = 1;

select * from medicines;

update patients
set doctor_id = 3
where patient_id = 2;

alter table doctors
add column phone_number varchar(20);

select * from doctors;

alter table patients
add column email varchar(100) unique;

select * from patients;

alter table medicines
add constraint price_check
check (price >= 0);

update doctors
set doctor_id = 5
where doctor_id = 2;

select * from doctors;

create table doctor_patient (
    doctor_id int,
    patient_id int,
    primary key (doctor_id, patient_id),
    foreign key (doctor_id) references doctors(doctor_id)
    on delete cascade
    on update cascade,
    foreign key (patient_id) references patients(patient_id)
    on delete cascade
    on update cascade
);


insert into doctor_patient (doctor_id, patient_id)
values
(1,1),
(1,3),
(2,2),
(3,4),
(3,5);

select * from doctors

update doctors
set doctor_id = 1
where doctor_id = 10;

select * from patients


delete from patient_medicine
where patient_id = 5;

delete from patients
where patient_id = 5;


insert into doctors
(first_name, middle_name, last_name, specialization, qualification, salary)
values
('Margo','m','hassan','cardiology','master',15000),
('sanaa','a','mahmoud','dermatology','master',12000),
('saad','k','fathy','neurology','master',18000);

select *
from doctors
where specialization = 'cardiology'
and salary > 12000;

select *
from patients
where first_name like 'M%';


select *
from doctors
where salary between 10000 and 20000;


select *
from doctors
where specialization in ('cardiology','dermatology');

select *
from doctors
where specialization != 'neurology';

alter table patients
alter column phone type varchar(20);

update patients
set phone = '01012345678'
where patient_id = 1;



select *
from patients
where phone is null;

select first_name, salary,
case
    when salary > 15000 then 'high salary'
    else 'normal salary'
end as salary_status
from doctors;

select *
from patients
where doctor_id = 1;

create table high_salary_doctors as
select *
from doctors
where salary > 15000;

--join
select distinct d.*
from doctors d
join patients p
on d.doctor_id = p.doctor_id;


select *
from doctors d1
where exists (
    select 1
    from doctors d2
    where d2.specialization = 'cardiology'
    and d1.salary > d2.salary
);

select *
from patients
where first_name similar to '(A|M)%';

select *
from patients
where first_name ~ '^(A|M)';

select distinct specialization
from doctors;

select first_name,
age(current_date, dob) as age
from patients;

select
upper(first_name),
lower(first_name),
initcap(first_name)
from patients;

select trim(phone)
from patients;

select concat(first_name,' - ',phone) as contact_info
from patients;

select
substring(first_name from 1 for 3) as first_three,
position('a' in first_name) as position_of_a
from patients;

select replace(first_name,'Ali','ahmad')
from doctors;


select
salary::int as salary_integer,
salary::text as salary_text
from doctors;
