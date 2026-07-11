drop table if exists main_data_01;
create table main_data_01 as 
SELECT *,
       DENSE_RANK() OVER (
           ORDER BY first_name, last_name, dob, gender, job, street, city, state, zip
       ) AS customer_id,
       DENSE_RANK() OVER (
           ORDER BY merchant, category
       ) AS merchant_id
FROM main_data;

select count(distinct customer_id), count(distinct merchant_id) from main_data_01;

select * from main_data_01 limit 10;

describe main_data_01;

drop table if exists main_data;
create table main_data as select
	txn_key,
	trans_date_trans_time,
	trans_date,
	trans_time,
	unix_time,
	trans_num,
	cc_num,
	amount,
	customer_id,
	first_name,
	last_name,
	gender,
	dob,
    TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age,
	job,
	street,
	city,
	state,
	zip,
	cust_lat,
	cust_long,
	city_pop,
	merchant_id,
	merchant,
	category,
	merch_lat,
	merch_long,
	fraud_ind
from main_data_01;

select * from main_data limit 10;
