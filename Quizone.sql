CREATE TABLE doctors (
    doctor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    middle_name VARCHAR(50),
    last_name VARCHAR(50),
    specialization VARCHAR(100),
    qualification VARCHAR(100)
);
CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    locality VARCHAR(100),
    city VARCHAR(100),
    doctor_id INT,
    FOREIGN KEY (doctor_id)
    REFERENCES doctors(doctor_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE medicines (
    code SERIAL PRIMARY KEY,
    medicine_name VARCHAR(100),
    price NUMERIC,
    quantity INT
);

CREATE TABLE patient_medicine (
    bill_id SERIAL PRIMARY KEY,
    patient_id INT,
    medicine_code INT,
    quantity INT,
    bill_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (medicine_code) REFERENCES medicines(code)
);

INSERT INTO doctors (first_name,middle_name,last_name,specialization,qualification)
VALUES
('Ali','M','Hassan','Heart','Master'),
('Sara','A','Mahmoud','skin','Master'),
('Omar','K','Fathy','kids','Master');

INSERT INTO patients (first_name,last_name,dob,locality,city,doctor_id)
VALUES
('Ahmed','Ali','1995-02-10','Nasr City','Cairo',1),
('Mona','Hassan','1998-06-12','Maadi','Cairo',2),
('Youssef','Adel','2000-01-05','Dokki','Giza',1),
('Salma','Nabil','1997-08-15','Heliopolis','Cairo',3),
('Karim','Samy','1999-03-20','Zamalek','Cairo',2);

INSERT INTO medicines (medicine_name,price,quantity)
VALUES
('Panadol',20,100),
('augmanteen',50,40),
('brufen',30,60),
('insulin',120,20),
('Aspirin',15,80);

INSERT INTO patient_medicine (patient_id,medicine_code,quantity,bill_date)
VALUES
(1,1,2,'2026-03-01'),
(2,3,1,'2025-03-02'),
(3,2,3,'2025-03-03'),
(4,5,2,'2026-03-04'),
(5,4,1,'2026-03-05');

UPDATE medicines
SET price = price + 10
WHERE code = 1;

select * from medicines

UPDATE patients
SET doctor_id = 3
WHERE patient_id = 2;

ALTER TABLE doctors
ADD COLUMN phone_number VARCHAR(20);

SELECT * FROM DOCTORS

ALTER TABLE patients
ADD COLUMN email VARCHAR(100) UNIQUE;

SELECT * FROM PATIENTS

ALTER TABLE medicines
ADD CONSTRAINT price_check
CHECK (price >= 0);

UPDATE doctors
SET doctor_id = 5
WHERE doctor_id = 2;

select * from doctors