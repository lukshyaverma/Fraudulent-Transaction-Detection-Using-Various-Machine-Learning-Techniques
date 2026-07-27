create table dev_data as
	select
		txn_key,
        trim(upper(state)) as state,
        trim(upper(category)) as category,
        cast(left(trans_time, 2) as unsigned) as trans_hour,
        amount,
        age,
        merch_ftg_30d,
        cat_ftg_30d,
        cm_merch_good_txn_30d,
        cm_cat_good_txn_30d,
        cust_amt_vs_avg_ratio_30d,
        cust_amt_vs_max_ratio_30d,
        merch_amt_vs_avg_ratio_30d,
        merch_amt_vs_max_ratio_30d,
        cust_txn_cnt_24h,
        cust_velocity_ratio_30d,
        fraud_ind
from main_data
where trans_date between '2020-08-01' and '2020-10-31'
;

create table test_data as
	select
		txn_key,
        trim(upper(state)) as state,
        trim(upper(category)) as category,
        cast(left(trans_time, 2) as unsigned) as trans_hour,
        amount,
        age,
        merch_ftg_30d,
        cat_ftg_30d,
        cm_merch_good_txn_30d,
        cm_cat_good_txn_30d,
        cust_amt_vs_avg_ratio_30d,
        cust_amt_vs_max_ratio_30d,
        merch_amt_vs_avg_ratio_30d,
        merch_amt_vs_max_ratio_30d,
        cust_txn_cnt_24h,
        cust_velocity_ratio_30d,
        fraud_ind
from main_data
where trans_date between '2020-11-01' and '2020-11-30'
;
