create database if not exists fraud_project;
use fraud_project;

drop table main_data;
create table main_data(
	txn_key int primary key,
	trans_date_trans_time varchar(20),
	cc_num bigint,
	merchant varchar(50),
	category varchar(20),
	amount double,
	first_name varchar(20),
	last_name varchar(20),
	gender varchar(1),
	street varchar(50),
	city varchar(50),
	state varchar(2),
	zip bigint,
	lat decimal(10,4),
	lon decimal(10,4),
	city_pop bigint,
	job varchar(100),
	dob varchar(20),
	trans_num varchar(50),
	unix_time bigint,
	merch_lat decimal(10,4),
	merch_long decimal(10,4),
	fraud_ind int
);

DESCRIBE main_data;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/kaggle_fraud.csv'
INTO TABLE main_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from main_data limit 5;
