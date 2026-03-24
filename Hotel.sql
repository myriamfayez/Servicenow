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
    hotel_id int references hotels(hotel_id) on delete cascade,
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




-- best hotel 
select h.name, avg(r.rating) as avg_rating, count(r.review_id) as total_reviews
from hotels h
left join reviews r on h.hotel_id = r.hotel_id
group by h.name
order by avg_rating desc;


-- available rooms in cairo
select h.name as hotel, r.room_type, r.price
from rooms r
join hotels h on r.hotel_id = h.hotel_id
where h.location = 'cairo' and r.is_available = true;

-- lowest flight price
select f.flight_id, a.name as airline, f.departure_city, f.arrival_city, f.price
from flights f
join airlines a on f.airline_id = a.airline_id
order by f.price asc;

-- users did payments
select u.name, sum(p.amount) as total_paid
from users u
join payments p on u.user_id = p.user_id
group by u.name
order by total_paid desc;


-- no of reservations for each user
select u.name, count(hb.booking_id) as total_bookings
from users u
left join hotel_bookings hb on u.user_id = hb.user_id
group by u.name;

--bookings based on date

select date(created_at) as booking_date, count(*) as total_bookings
from hotel_bookings
group by booking_date
order by booking_date;

-- hotels has max reservations 
select h.name, count(hb.booking_id) as bookings_count
from hotels h
join rooms r on h.hotel_id = r.hotel_id
join hotel_bookings hb on r.room_id = hb.room_id
group by h.name
order by bookings_count desc;

--users reserved hotel and flight 

select distinct u.name
from users u
join hotel_bookings hb on u.user_id = hb.user_id
join flight_bookings fb on u.user_id = fb.user_id
where hb.status = 'confirmed' and fb.status = 'confirmed';



--avg rate for each hotel 
select h.name, round(avg(r.rating),2) as avg_rating
from hotels h
join reviews r on h.hotel_id = r.hotel_id
group by h.name;
-- flights have limits seats 
select flight_id, departure_city, arrival_city, available_seats
from flights
where available_seats < 20;