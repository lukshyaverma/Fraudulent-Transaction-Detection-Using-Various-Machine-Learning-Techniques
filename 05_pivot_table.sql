describe main_data;

select 
    count(distinct txn_key) as txn_key_dist,
    count(distinct trans_date_trans_time) as trans_date_trans_time_dist,
    count(distinct trans_date) as trans_date_dist,
    count(distinct trans_time) as trans_time_dist,
    count(distinct unix_time) as unix_time_dist,
    count(distinct trans_num) as trans_num_dist,
    count(distinct cc_num) as cc_num_dist,
    count(distinct amount) as amount_dist,
    count(distinct customer_id) as customer_id_dist,
    count(distinct first_name) as first_name_dist,
    count(distinct last_name) as last_name_dist,
    count(distinct gender) as gender_dist,
    count(distinct cm_merch_dist) as cm_merch_dist_dist,
    count(distinct dob) as dob_dist,
    count(distinct age) as age_dist,
    count(distinct job) as job_dist,
    count(distinct street) as street_dist,
    count(distinct city) as city_dist,
    count(distinct state) as state_dist,
    count(distinct zip) as zip_dist,
    count(distinct cust_lat) as cust_lat_dist,
    count(distinct cust_long) as cust_long_dist,
    count(distinct city_pop) as city_pop_dist,
    count(distinct merchant_id) as merchant_id_dist,
    count(distinct merchant) as merchant_dist,
    count(distinct category) as category_dist,
    count(distinct merch_lat) as merch_lat_dist,
    count(distinct merch_long) as merch_long_dist,
    count(distinct fraud_ind) as fraud_ind_dist
from main_data;

drop table if exists pivot_01;
create table pivot_01 as select
    trans_date,
        case 
        when amount <= 1 then 'A_lt_10'
        when amount < 10 then 'B_10_100'
        when amount < 100 then 'C_100_1000'
        when amount < 1000 then 'D_1000_10000'
        else 'E_gt_10000'
    end as amount_bt,
        case 
        when cm_merch_dist < 10 then 'A_lt_10'
        when cm_merch_dist < 50 then 'B_10_50'
        when cm_merch_dist < 100 then 'C_50_100'
        else 'D_gt_100'
    end as cm_merch_dist_bkt,
    gender,
        case
        when age < 30 then 'A_lt_30'
        when age < 60 then 'B_lt_60'
        else 'C_gt_60'
    end as age_bkt,
    category,
    city,
    state,
    zip,
    count(*) as total_txn,
    sum(fraud_ind) as frd_txn,
    sum(amount) as total_amt,
    sum(case when fraud_ind = 1 then amount else 0 end) as frd_amt
from main_data
group by 1,2,3,4,5,6,7,8,9;

select * from pivot_01 limit 10;

SELECT *
FROM pivot_01
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pivot_01.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
