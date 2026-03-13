create table doctors (
    doctor_id serial primary key,
    first_name varchar(50),
    middle_name varchar(50),
    last_name varchar(50),
    specialization varchar(100),
    qualification varchar(100)
);

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
