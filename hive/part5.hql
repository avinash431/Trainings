CREATE TABLE page_views (logtime STRING, userid INT, ip STRING, page STRING, ref STRING, os STRING, os_ver STRING, agent STRING)
PARTITIONED BY (y STRING, m STRING, d STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t';

LOAD DATA LOCAL INPATH '/media/sf_VM_Share/LogFiles/log_2013805_16210.log'
OVERWRITE INTO TABLE page_views PARTITION (y='2013', m='08', d='05');


CREATE EXTERNAL TABLE staging (logtime STRING, userid INT, ip STRING, page STRING, ref STRING, os STRING, os_ver STRING, agent STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/pluralsight/logs/multi_insert';

INSERT INTO TABLE page_views PARTITION (y, m, d)
SELECT logtime, userid, ip, page, ref, os, os_ver, agent, substr(logtime, 7, 4), substr(logtime, 1, 2), substr(logtime, 4, 2)
FROM staging;

SET hive.exec.dynamic.partition.mode=nonstrict;

INSERT INTO TABLE page_views PARTITION (y, m, d)
SELECT logtime, userid, ip, page, ref, os, os_ver, agent, substr(logtime, 7, 4), substr(logtime, 1, 2), substr(logtime, 4, 2)
FROM staging;

SELECT * FROM page_views WHERE y='2012' LIMIT 100;

select regexp_replace(logtime, '/', '-') from staging;
select substr(logtime, 7, 4), substr(logtime, 1, 2), substr(logtime, 4, 2) from staging;
