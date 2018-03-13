Hive
—————

show databases;

show databases like 'fo*'

use focus;

show tables;

Terminal
————————

hadoop fs  -ls /user/hive/warehouse

hadoop fs -ls /user/hive/warehouse/focus.db

hadoop fs -ls /user/hive/warehouse/focus.db/customers

Hive
————

use default;

create table test(id int, name string);

show tables;


Terminal
—————————

hadoop fs -ls /user/hive/warehouse/

hadoop fs -ls /user/hive/warehouse/test

insert into test values (1234, 'Janani');

hadoop fs -cat /user/hive/warehouse/test/


Hive
—————
drop table test;


Terminal
————————

nano products.csv 


hadoop fs -mkdir -p /user/focus/hive/products

hadoop fs -copyFromLocal products.csv /user/focus/hive/products

hadoop fs -ls /user/focus/hive/products


Hive
————

create external table if not exists products (
id string,
title string,
cost float
)
comment "Table to store product information sold in stores"
location '/user/focus/hive/products/';

select * from products;
(This is not what we wanted)


Terminal
————————

hadoop fs -ls /user/hive/warehouse/focus.db
(There should be nothing here)

hadoop fs -ls /data/
(The data is here)

drop table products;

hadoop fs -ls /data/
(The data is still here)


Hive
————————

create external table if not exists products (
id string,
title string,
cost float
)
comment "Table to store product information sold in stores"
row format delimited fields terminated by ','
stored as textfile
location '/data/';

select * from products;
(This is now how we want it)

describe formatted customers;
(Data should be in the warehouse, table type should be managed_table)

describe formatted products;
(Data should be in the HDFS location where we have placed it, table type should be external_table)


create table if not exists fresh_products like products;

show tables;

describe fresh_products;

alter table fresh_products rename to freshproducts;

show tables;

alter table freshproducts add columns (
expiry_date date 
comment "Expiry date of fresh produce"
);

describe freshproducts;

alter table freshproducts change column id id string after title;

alter table products change column id id string after title;
(Note that the data does not change)


create temporary table test_customers  like customers;

show tables;

describe test_customers;

insert into test_customers values (
9999,"Jill","MN");

select * from test_customers;


alter table freshproducts
change column title title string
after id;


load data local inpath 'freshproducts.csv'
into table freshproducts; 
(This is from a local path and not HDFS)

select * from freshproducts;
(Note the null padding where we do not have information)


Terminal
————————

hadoop fs -ls /user/hive/warehouse/focus.db

hadoop fs -ls /user/hive/warehouse/focus.db/freshproducts

hadoop fs -cat /user/hive/warehouse/focus.db/freshproducts/

(The CSV file has been moved into the warehouse directory)

(From hdfs)

hadoop fs -copyFromLocal freshproducts.csv /data/



Hive
————————


load data inpath '/data/freshproducts.csv' into table freshproducts; 

select * from freshproducts;

(Notice the data is appended, and both files are present in the warehouse directory)


Terminal
————————

hadoop fs -ls /user/hive/warehouse/freshproducts/

hadoop fs -cat /user/hive/warehouse/freshproducts/

(Both files are present in the warehouse directory)

hadoop fs -ls /data/
(But the original file in Hadoop has moved in this case)


load data local inpath 'freshproducts.csv'
overwrite into table freshproducts; 

select * from freshproducts;


insert into table products
select id, title, cost from freshproducts;

select * from products;

insert overwrite table products
select id, title, cost from freshproducts;

select * from freshproducts;

alter table products
change column title title string
after id;

create table product_name (id string, name string);

create table product_cost (id string, cost float);


from products
insert overwrite table product_name
select id, title
insert into table product_cost
select id, cost;

select * from product_name;

select * from product_cost;

truncate table freshproducts;

select * from freshproducts;

