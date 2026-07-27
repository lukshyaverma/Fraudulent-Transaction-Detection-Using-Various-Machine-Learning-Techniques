drop table if exists var_rnp;
create table var_rnp as
select
    *,
    ntile(10) over (order by merch_ftg_30d) as merch_ftg_30d_bkt,
    ntile(10) over (order by cat_ftg_30d) as cat_ftg_30d_bkt,
    ntile(10) over (order by cm_merch_good_txn_30d) as cm_merch_good_txn_30d_bkt,
    ntile(10) over (order by cm_cat_good_txn_30d) as cm_cat_good_txn_30d_bkt,
    ntile(10) over (order by cust_amt_vs_avg_ratio_30d) as cust_amt_vs_avg_ratio_30d_bkt,
    ntile(10) over (order by cust_amt_vs_max_ratio_30d) as cust_amt_vs_max_ratio_30d_bkt,
    ntile(10) over (order by merch_amt_vs_avg_ratio_30d) as merch_amt_vs_avg_ratio_30d_bkt,
    ntile(10) over (order by merch_amt_vs_max_ratio_30d) as merch_amt_vs_max_ratio_30d_bkt,
    ntile(10) over (order by cust_txn_cnt_24h) as cust_txn_cnt_24h_bkt,
    ntile(10) over (order by cust_velocity_ratio_30d) as cust_velocity_ratio_30d_bkt
from main_data_01
where trans_date between '2020-08-01' and '2020-11-30'
;

select * from var_rnp limit 10;
select count(*) from var_rnp;
describe var_rnp;

drop table if exists var_rnp_pivot;
create table var_rnp_pivot as 
select
    merch_ftg_30d_bkt,
    cat_ftg_30d_bkt,
    cm_merch_good_txn_30d_bkt,
    cm_cat_good_txn_30d_bkt,
    cust_amt_vs_avg_ratio_30d_bkt,
    cust_amt_vs_max_ratio_30d_bkt,
    merch_amt_vs_avg_ratio_30d_bkt,
    merch_amt_vs_max_ratio_30d_bkt,
    cust_txn_cnt_24h_bkt,
    cust_velocity_ratio_30d_bkt,
    count(*) as total_txn,
    sum(fraud_ind) as frd_txn,
    sum(amount) as total_amt,
    sum(case when fraud_ind = 1 then amount else 0 end) as frd_amt
from var_rnp
group by 1,2,3,4,5,6,7,8,9,10;

select * from var_rnp_pivot limit 10;

SELECT *
FROM var_rnp_pivot
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/var_rnp_pivot.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

describe var_rnp_pivot;
