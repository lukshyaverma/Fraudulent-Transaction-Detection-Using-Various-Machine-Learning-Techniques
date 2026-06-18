create database if not exists fraud_project;
use fraud_project;

select * from main_data limit 10;

drop table if exists main_data_01;
create table main_data_01 as select
	txn_key,
	trans_date_trans_time,
	SUBSTRING_INDEX(trans_date_trans_time, ' ', 1) AS trans_date,
	SUBSTRING_INDEX(trans_date_trans_time, ' ', -1) AS trans_time,
	cc_num,
	amount,
	first_name,
	last_name,
	gender,
	dob,
	job,
	street,
	city,
	state,
	zip,
	lat as cust_lat,
	lon as cust_long,
	city_pop,
	merchant,
	category,
	merch_lat,
	merch_long,
	unix_time,
	trans_num,
	fraud_ind
from main_data;

select * from main_data_01 limit 10;

drop table if exists main_data_02;
create table main_data_02 as select
	txn_key,
	trans_date_trans_time,
	STR_TO_DATE(trans_date, '%d-%m-%Y') as trans_date,
	trans_time,
	unix_time,
	trans_num,
	cc_num,
	amount,
	first_name,
	last_name,
	gender,
	STR_TO_DATE(dob, '%d-%m-%Y') as dob,
	job,
	street,
	city,
	state,
	zip,
	cust_lat,
	cust_long,
	city_pop,
	merchant,
	category,
	merch_lat,
	merch_long,
	fraud_ind
from main_data_01;

select * from main_data_02 limit 10;

describe main_data_02;

drop table main_data;
alter table main_data_02 rename to main_data;

describe main_data;
