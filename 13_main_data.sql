DROP TABLE IF EXISTS main_data_01;
CREATE TABLE main_data_01 AS
SELECT
    a.txn_key,
    a.trans_date_trans_time,
    a.trans_date,
    a.trans_time,
    a.unix_time,
    a.trans_num,
    a.cc_num,
    a.amount,
    a.customer_id,
    a.first_name,
    a.last_name,
    a.gender,
    a.cm_merch_dist,
    a.dob,
    a.age,
    a.job,
    a.street,
    a.city,
    a.state,
    a.zip,
    a.cust_lat,
    a.cust_long,
    a.city_pop,
    a.merchant_id,
    a.merchant,
    a.category,
    a.merch_lat,
    a.merch_long,
    b.merch_frd_txn_30d,
    b.merch_tot_txn_30d,
    b.merch_ftg_30d,
    c.cat_frd_txn_30d,
    c.cat_tot_txn_30d,
    c.cat_ftg_30d,
    d.cm_merch_good_txn_30d,
    e.cm_cat_good_txn_30d,
    f.cust_avg_amt_30d,
    f.cust_max_amt_30d,
    f.cust_amt_vs_avg_ratio_30d,
    f.cust_amt_vs_max_ratio_30d,
    g.merch_avg_amt_30d,
    g.merch_max_amt_30d,
    g.merch_amt_vs_avg_ratio_30d,
    g.merch_amt_vs_max_ratio_30d,
    h.cust_txn_cnt_24h,
    h.cust_txn_cnt_24h_avg_30d,
    h.cust_velocity_ratio_30d,
    sum(a.fraud_ind) over(partition by a.customer_id) as tot_cust_frd_txn,
    sum(case when a.fraud_ind = 1 then a.amount else 0 end) over(partition by a.customer_id) as tot_cust_fraud_amt,
    sum(a.fraud_ind) over(partition by a.merchant_id) as tot_merch_frd_txn,
    sum(case when a.fraud_ind = 1 then a.amount else 0 end) over(partition by a.merchant_id) as tot_merch_fraud_amt,
    a.fraud_ind
FROM main_data a
INNER JOIN merch_ftg b
ON a.txn_key = b.txn_key
INNER JOIN cat_ftg c
ON a.txn_key = c.txn_key
INNER JOIN cm_merch_good_hist d
ON a.txn_key = d.txn_key
INNER JOIN cm_cat_good_hist e
ON a.txn_key = e.txn_key
INNER JOIN cm_amount_oop f
ON a.txn_key = f.txn_key
INNER JOIN merch_amount_oop g
ON a.txn_key = g.txn_key
INNER JOIN cm_velocity h
ON a.txn_key = h.txn_key
;

SELECT *
FROM main_data_01
LIMIT 100;

SELECT COUNT(*)
FROM main_data_01;

DESCRIBE main_data_01;

SELECT
    'txn_key',
    'trans_date_trans_time',
    'trans_date',
    'trans_time',
    'unix_time',
    'trans_num',
    'cc_num',
    'amount',
    'customer_id',
    'first_name',
    'last_name',
    'gender',
    'cm_merch_dist',
    'dob',
    'age',
    'job',
    'street',
    'city',
    'state',
    'zip',
    'cust_lat',
    'cust_long',
    'city_pop',
    'merchant_id',
    'merchant',
    'category',
    'merch_lat',
    'merch_long',
    'merch_frd_txn_30d',
    'merch_tot_txn_30d',
    'merch_ftg_30d',
    'cat_frd_txn_30d',
    'cat_tot_txn_30d',
    'cat_ftg_30d',
    'cm_merch_good_txn_30d',
    'cm_cat_good_txn_30d',
    'cust_avg_amt_30d',
    'cust_max_amt_30d',
    'cust_amt_vs_avg_ratio_30d',
    'cust_amt_vs_max_ratio_30d',
    'merch_avg_amt_30d',
    'merch_max_amt_30d',
    'merch_amt_vs_avg_ratio_30d',
    'merch_amt_vs_max_ratio_30d',
    'cust_txn_cnt_24h',
    'cust_txn_cnt_24h_avg_30d',
    'cust_velocity_ratio_30d',
    'tot_cust_frd_txn',
    'tot_cust_fraud_amt',
    'tot_merch_frd_txn',
    'tot_merch_fraud_amt',
    'fraud_ind'
UNION
SELECT
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
    cm_merch_dist,
    dob,
    age,
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
    merch_frd_txn_30d,
    merch_tot_txn_30d,
    merch_ftg_30d,
    cat_frd_txn_30d,
    cat_tot_txn_30d,
    cat_ftg_30d,
    cm_merch_good_txn_30d,
    cm_cat_good_txn_30d,
    cust_avg_amt_30d,
    cust_max_amt_30d,
    cust_amt_vs_avg_ratio_30d,
    cust_amt_vs_max_ratio_30d,
    merch_avg_amt_30d,
    merch_max_amt_30d,
    merch_amt_vs_avg_ratio_30d,
    merch_amt_vs_max_ratio_30d,
    cust_txn_cnt_24h,
    cust_txn_cnt_24h_avg_30d,
    cust_velocity_ratio_30d,
    tot_cust_frd_txn,
    tot_cust_fraud_amt,
    tot_merch_frd_txn,
    tot_merch_fraud_amt,
    fraud_ind
FROM main_data_01
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/main_data_01.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
