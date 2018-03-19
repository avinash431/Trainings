DROP TABLE IF EXISTS users;

CREATE TABLE users (id INT, name STRING);

LOAD DATA LOCAL INPATH 'input/hive/tables/users.txt'
OVERWRITE INTO TABLE users;

hdfs -cat /user/hive/warehouse/users/users.txt;

DROP TABLE IF EXISTS bucketed_users;

CREATE TABLE bucketed_users (id INT, name STRING)
CLUSTERED BY (id) INTO 4 BUCKETS;

DROP TABLE bucketed_users;

CREATE TABLE bucketed_users (id INT, name STRING)
CLUSTERED BY (id) SORTED BY (id) INTO 4 BUCKETS;

SELECT * FROM users;

SET hive.enforce.bucketing=true;

INSERT OVERWRITE TABLE bucketed_users
SELECT * FROM users;

hdfs -ls /user/hive/warehouse/bucketed_users;

hdfs -cat /user/hive/warehouse/bucketed_users/000000_0;


SELECT * FROM bucketed_users
TABLESAMPLE(BUCKET 1 OUT OF 4 ON id);

SELECT * FROM bucketed_users
TABLESAMPLE(BUCKET 1 OUT OF 2 ON id);


SELECT * FROM users
TABLESAMPLE(BUCKET 1 OUT OF 4 ON rand());
