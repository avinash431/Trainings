Hive
————
show tables;

create database focus;
use focus;

create table customers (
id bigint,name string,city string);

show tables;
describe customers;

insert into customers values (
1111, "Avinash", "Hyd"
);

insert into customers values 
(2222, "Prasanna", "Det"), 
(3333, "Manju", "Hyd"),
(4444, "Rajeev", "Bgl"),
(5555, "Anupama", "Chn"), 
(6666, "Gautam", "Del");

select * from customers where city = "Hyd";

select name, city from customers where city = "Hyd";

select name, city from customers where city = "Hyd" and id > 2222;

select DISTINCT city from customers;

select name, city from customers order by city;

select count(*) from customers;

select city, count(*) from customers group by city;

select city, count(*) as customer_count from customers group by city;

select * from customers limit 1;


create table if not exists orders (
id bigint, 
product_id string, 
customer_id bigint, 
quantity int, 
amount double
);

insert into orders values (
111111,"phone",1111,3,1200);

insert into orders values (
111112,"camera", 1111, 1, 5200),
(111113, "broom", 1111, 1, 10),
(111114,"broom",2222,2,20), 
(111115,"t-shirt",4444,2,66);


select customers.id, name, product_id 
from customers join orders 
where customers.id = orders.customer_id; 
