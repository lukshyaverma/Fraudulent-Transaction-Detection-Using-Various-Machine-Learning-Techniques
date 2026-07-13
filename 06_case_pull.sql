use fraud_project;
select * 
from main_data
order by unix_time
limit 100; 

drop table if exists case_pull;
create table case_pull as
select txn_key, unix_time, trans_date, trans_time, cc_num, amount, customer_id, first_name, last_name, gender, cm_merch_dist, dob, age, job, street, city, state, zip, merchant_id, merchant, category, 
sum(fraud_ind) over(partition by customer_id) as tot_cust_frd_txn,
sum(case when fraud_ind = 1 then amount else 0 end) over(partition by customer_id) as tot_cust_fraud_amt,
fraud_ind
from main_data;

SELECT
    'txn_key', 'unix_time', 'trans_date', 'trans_time', 'cc_num',
    'amount', 'customer_id', 'first_name', 'last_name', 'gender',
    'cm_merch_dist', 'dob', 'age', 'job', 'street', 'city',
    'state', 'zip', 'merchant_id', 'merchant', 'category',
    'tot_cust_frd_txn', 'tot_cust_fraud_amt', 'fraud_ind'
UNION
SELECT
    txn_key, unix_time, trans_date, trans_time, cc_num,
    amount, customer_id, first_name, last_name, gender,
    cm_merch_dist, dob, age, job, street, city,
    state, zip, merchant_id, merchant, category,
    tot_cust_frd_txn, tot_cust_fraud_amt, fraud_ind
FROM case_pull
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/case_pull.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

select customer_id, max(tot_cust_frd_txn)
from case_pull
group by 1
order by 2 desc
limit 100;
