create table users (
    user_id serial primary key,
    name varchar(100) not null,
    email varchar(150) unique not null,
    phone varchar(20),
    password text not null,
    role varchar(20) check (role in ('customer','admin')) default 'customer',
    created_at timestamp default current_timestamp);

insert into users (name, email, phone, password, role) values
('ahmed ali','ahmed@gmail.com','01000000001','123456','customer'),
('mohamed said','mohamed@gmail.com','01000000002','123456','customer'),
('sara gamal','sara@gmail.com','01000000003','123456','customer'),
('admin user','admin@gmail.com','01000000004','admin123','admin');




ALTER TABLE users ALTER COLUMN password TYPE text;

CREATE EXTENSION IF NOT EXISTS pgcrypto; 


INSERT INTO users (name, email, password)
VALUES (
  'mariam',
  'm@gmail.com',
  crypt('123456', gen_salt('bf'))); --bf encry type , every time generate new salt even if same pass for users
  

update users set password = crypt(password, gen_salt('bf'));

select * from users



create table hotels (
    hotel_id serial primary key,
    name varchar(150) not null,
    location varchar(150) not null,
    rating decimal(2,1),
    description text);

insert into hotels (name, location, rating, description) values
('nile view hotel','cairo',4.5,'nice hotel with nile view'),
('alex sea hotel','alexandria',4.2,'hotel near the sea'),
('luxor palace','luxor',5.0,'luxury hotel');



create table rooms (
    room_id serial primary key,
    hotel_id int references hotels(hotel_id) on delete cascade, -- whwn parent deleted what should we do in children in table of fk 
    room_type varchar(50),
    price decimal(10,2),
    is_available boolean default true);

insert into rooms (hotel_id, room_type, price, is_available) values
(1,'single',500,true),
(1,'double',800,true),
(2,'single',400,true),
(2,'suite',1200,true),
(3,'double',900,true);



create table hotel_bookings (
    booking_id serial primary key,
    user_id int references users(user_id),
    room_id int references rooms(room_id),
    check_in date,
    check_out date,
    total_cost decimal(10,2),
    status varchar(20) check (status in ('confirmed','cancelled')) default 'confirmed',
    created_at timestamp default current_timestamp);

insert into hotel_bookings (user_id, room_id, check_in, check_out, total_cost, status) values
(1,1,'2026-04-01','2026-04-05',2000,'confirmed'),
(2,2,'2026-04-03','2026-04-06',2400,'confirmed'),
(3,3,'2026-04-10','2026-04-12',800,'cancelled');



create table airlines (
    airline_id serial primary key,
    name varchar(100));

insert into airlines (name) values
('egyptair'),
('air cairo'),
('flynas');




create table flights (
    flight_id serial primary key,
    airline_id int references airlines(airline_id),
    departure_city varchar(100),
    arrival_city varchar(100),
    departure_time timestamp,
    arrival_time timestamp,
    price decimal(10,2),
    total_seats int,
    available_seats int);
    

insert into flights (airline_id, departure_city, arrival_city, departure_time, arrival_time, price, total_seats, available_seats) values
(1,'cairo','dubai','2026-04-01 10:00','2026-04-01 14:00',5000,150,140),
(2,'alexandria','riyadh','2026-04-02 12:00','2026-04-02 16:00',4500,120,100),
(3,'cairo','jeddah','2026-04-03 09:00','2026-04-03 13:00',4800,180,170);



create table flight_bookings (
    booking_id serial primary key,
    user_id int references users(user_id),
    flight_id int references flights(flight_id),
    seat_number varchar(10),
    status varchar(20) check (status in ('confirmed','cancelled')) default 'confirmed',
    created_at timestamp default current_timestamp);

insert into flight_bookings (user_id, flight_id, seat_number, status) values
(1,1,'a1','confirmed'),
(2,1,'a2','confirmed'),
(3,2,'b1','cancelled');



create table payments (
    payment_id serial primary key,
    user_id int references users(user_id),
    amount decimal(10,2),
    payment_method varchar(50),
    payment_date timestamp default current_timestamp,
    hotel_booking_id int references hotel_bookings(booking_id),
    flight_booking_id int references flight_bookings(booking_id));

insert into payments (user_id, amount, payment_method, hotel_booking_id, flight_booking_id) values
(1,2000,'credit card',1,null),
(2,2400,'vodafone cash',2,null),
(1,5000,'credit card',null,1);


create table reviews (
    review_id serial primary key,
    user_id int references users(user_id),
    hotel_id int references hotels(hotel_id),
    rating int check (rating between 1 and 5),
    comment text,
    created_at timestamp default current_timestamp);

insert into reviews (user_id, hotel_id, rating, comment) values
(1,1,5,'great hotel'),
(2,2,4,'nice place'),
(3,3,5,'amazing experience');



ALTER TABLE payments
ADD CONSTRAINT unique_hotel_booking UNIQUE (hotel_booking_id);

ALTER TABLE payments
ADD CONSTRAINT unique_flight_booking UNIQUE (flight_booking_id);










--aktar users by7gzo 
SELECT 
    u.user_id,
    u.name,
    COUNT(DISTINCT hb.booking_id) AS hotel_bookings,
    COUNT(DISTINCT fb.booking_id) AS flight_bookings
FROM users u
LEFT JOIN hotel_bookings hb ON u.user_id = hb.user_id
LEFT JOIN flight_bookings fb ON u.user_id = fb.user_id
GROUP BY u.user_id, u.name;



-- best hotels based on rating  to enable mangers make descions

SELECT 
    name,
    location,
    rating
FROM hotels
ORDER BY rating DESC;




-- no of rooms in each hotel to know the capacity
SELECT 
    h.name,
    COUNT(r.room_id) AS total_rooms
FROM hotels h
LEFT JOIN rooms r ON h.hotel_id = r.hotel_id
GROUP BY h.name;

-- total revenues of hotels 

SELECT 
    SUM(total_cost) AS total_hotel_revenue
FROM hotel_bookings
WHERE status = 'confirmed';


--total revenues of flights
SELECT 
    SUM(amount) AS total_flight_revenue
FROM payments
WHERE flight_booking_id IS NOT NULL;

-- available rooms in cairo 
SELECT 
    h.name AS hotel_name,
    r.room_type,
    r.price
FROM rooms r
JOIN hotels h ON r.hotel_id = h.hotel_id
WHERE r.is_available = true
AND h.location = 'cairo';

--report about hotels' reservations
SELECT 
    u.name AS user_name,
    h.name AS hotel_name,
    r.room_type,
    hb.check_in,
    hb.check_out,
    hb.total_cost,
    hb.status
FROM hotel_bookings hb
JOIN users u ON hb.user_id = u.user_id
JOIN rooms r ON hb.room_id = r.room_id
JOIN hotels h ON r.hotel_id = h.hotel_id;

--most flights reserved 
SELECT 
    f.flight_id,
    f.departure_city,
    f.arrival_city,
    COUNT(fb.booking_id) AS total_bookings
FROM flights f
LEFT JOIN flight_bookings fb ON f.flight_id = fb.flight_id
GROUP BY f.flight_id
ORDER BY total_bookings DESC;


--users cancelled their hotel reservation 
SELECT DISTINCT u.name
FROM users u
JOIN hotel_bookings hb ON u.user_id = hb.user_id
WHERE hb.status = 'cancelled';


--Most paid users
SELECT 
    u.name,
    SUM(p.amount) AS total_paid
FROM users u
JOIN payments p ON u.user_id = p.user_id
GROUP BY u.name
ORDER BY total_paid DESC;