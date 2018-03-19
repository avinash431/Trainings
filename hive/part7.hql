
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (name STRING, id INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

DROP TABLE IF EXISTS things;
CREATE TABLE things (id INT, name STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

LOAD DATA LOCAL INPATH 'input/hive/joins/sales.txt'
OVERWRITE INTO TABLE sales;

LOAD DATA LOCAL INPATH 'input/hive/joins/things.txt'
OVERWRITE INTO TABLE things;


SELECT * FROM sales;
SELECT * FROM things;



SELECT sales.*, things.*
FROM sales JOIN things ON (sales.id = things.id);



SELECT sales.*, things.*
FROM sales LEFT OUTER JOIN things ON (sales.id = things.id);



SELECT sales.*, things.*
FROM sales RIGHT OUTER JOIN things ON (sales.id = things.id);



SELECT sales.*, things.*
FROM sales FULL OUTER JOIN things ON (sales.id = things.id);



SELECT *
FROM things LEFT SEMI JOIN sales ON (sales.id = things.id);


SELECT /*+ MAPJOIN(things) */ sales.*, things.*
FROM sales JOIN things ON (sales.id = things.id);
