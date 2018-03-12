CREATE EXTERNAL TABLE users (
user_id INT,
age INT,
gender STRING,
occupation STRING,
zip_code STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

-- load data into the table users using load command.


describe formatted userinfo;

SELECT * FROM users limit 100;

SELECT age, occupation FROM users;

SELECT count(*) FROM users WHERE occupation = 'artist';

CREATE TABLE occupation2 LIKE occupation_count;

DESCRIBE FORMATTED occupation2;

SELECT * FROM occupation2;

CREATE EXTERNAL TABLE page_views_ext (logtime STRING, userid INT, ip STRING, page STRING, ref STRING, os STRING, os_ver STRING, agent STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t';

-- load data into the table page_views_ext using load command.