create table menu_items (
    id serial primary key,
    name varchar(100) not null);


	insert into menu_items (name) values
('Pizza'),
('Burger'),
('Pasta');


create table ingredients (
    id serial primary key,
    name varchar(100) not null,
    quantity int not null);

	insert into ingredients (name, quantity) values
('bread', 50),
('cheese', 40),
('tomato Sauce', 30),
('chicken', 20),
('Beef', 25),
('Pasta', 40);


create table recipes (
    id serial primary key,
    menu_item_id int,
    ingredient_id int,
    required_qty int,

    foreign key (menu_item_id) references menu_items(id),
    foreign key (ingredient_id) references ingredients(id));


	create table tables (
    id serial primary key,
    status varchar(20) check (status in ('available','reserved','occupied')));



	create table orders (
    id serial primary key,
    table_id int,

    foreign key (table_id) references tables(id));


	create table order_items (
    id serial primary key,
    order_id int,
    menu_item_id int,
    quantity int,

    foreign key (order_id) references orders(id),
    foreign key (menu_item_id) references menu_items(id));




	
insert into recipes (menu_item_id, ingredient_id, required_qty) values
(1, 1, 1),  
(1, 2, 2),  
(1, 3, 1);  


insert into recipes (menu_item_id, ingredient_id, required_qty) values
(2, 2, 1), 
(2, 5, 2);  


insert into recipes (menu_item_id, ingredient_id, required_qty) values
(3, 6, 2),  
(3, 3, 1);  





insert into tables (status) values
('available'),
('reserved'),
('occupied');

insert into orders (table_id) values
(1),
(2);


create table roles (
    id serial primary key,
    name varchar(50) not null);



insert into roles (name) values
('admin'),
('waiter'),
('chef');

create table users (
    id serial primary key,
    name varchar(100),
    role_id int,
    
    foreign key (role_id) references roles(id));

insert into users (name, role_id) values
('ali', 1),   
('sara', 2),  
('omar', 3);  








	


update tables
set status = 'occupied'
where id = 1;



insert into order_items (order_id, menu_item_id, quantity) values
(1, 1, 2),  
(1, 2, 1),  
(2, 3, 1);  


begin;
-- to check stock
select i.name, i.quantity, r.required_qty * oi.quantity as needed
from recipes r
join ingredients i on r.ingredient_id = i.id
join order_items oi on oi.menu_item_id = r.menu_item_id
where oi.order_id = 1;

-- to reduce ing
update ingredients i
set quantity = i.quantity - (r.required_qty * oi.quantity)
from recipes r
join order_items oi on oi.menu_item_id = r.menu_item_id
where i.id = r.ingredient_id
and oi.order_id = 1;

commit;

 rollback
 
--kitchen view

select o.id, m.name, oi.quantity
from orders o
join order_items oi on o.id = oi.order_id
join menu_items m on oi.menu_item_id = m.id;



--table status of table
update tables
set status = 'occupied'
where id = 1;