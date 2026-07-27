use fraud_project;
show tables;

drop table if exists pivot_03;
create table pivot_03 as 
select
    trans_date,
    cast(left(trans_time, 2) as unsigned) as trans_hour,
        case 
        when amount <= 1 then 'A_lte_1'
        when amount <= 10 then 'B_1_10'
        when amount <= 100 then 'C_10_100'
        when amount <= 1000 then 'D_100_1000'
        else 'E_gt_1000'
    end as amount_bt,
        case
        when age <= 30 then 'A_lte_30'
        when age <= 60 then 'B_30_60'
        else 'C_gt_60'
    end as age_bkt,
    gender,
    category,
    state,
    cm_merch_good_txn_30d,
    count(*) as total_txn,
    sum(fraud_ind) as frd_txn,
    sum(amount) as total_amt,
    sum(case when fraud_ind = 1 then amount else 0 end) as frd_amt
from main_data_01
group by 1,2,3,4,5,6,7,8;

select * from pivot_03 limit 10;

SELECT *
FROM pivot_03
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pivot_03.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
