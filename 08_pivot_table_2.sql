drop table if exists pivot_02;
create table pivot_02 as select
    trans_date,
    cast(left(trans_time, 2) as unsigned) as trans_hour,
        case 
        when amount <= 1 then 'A_lt_10'
        when amount < 10 then 'B_10_100'
        when amount < 100 then 'C_100_1000'
        when amount < 1000 then 'D_1000_10000'
        else 'E_gt_10000'
    end as amount_bt,
        case
        when age < 30 then 'A_lt_30'
        when age < 60 then 'B_lt_60'
        else 'C_gt_60'
    end as age_bkt,
    category,
    state,
    count(*) as total_txn,
    sum(fraud_ind) as frd_txn,
    sum(amount) as total_amt,
    sum(case when fraud_ind = 1 then amount else 0 end) as frd_amt
from main_data
group by 1,2,3,4,5,6;

select * from pivot_02 limit 10;

SELECT *
FROM pivot_02
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/pivot_02.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
