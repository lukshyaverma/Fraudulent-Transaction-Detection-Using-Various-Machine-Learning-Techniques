#creation of ftg variables requires to look back a fixed time period so that there is uniformity. We had chosen a time period of past 30 days and chosen unix_time for this. 
  However the computation of this is very heavy due to a self join of a large table. We can do this computation in python or pyspark and run a day wise or merchant wise loop.
  But for the purpose of this project we would instead use a simple window function which looks at all the past records. It isn't ideal but much less computationaly heavy. 

CREATE TABLE merch_ftg as
SELECT
    a.txn_key,
    a.merchant_id,
    a.unix_time,
    COALESCE(SUM(b.fraud_ind),0) AS merch_frd_txn_30d,
    COALESCE(COUNT(b.txn_key),0) AS merch_tot_txn_30d,
    COALESCE((SUM(b.fraud_ind) / NULLIF(COUNT(b.txn_key),0)),0)*100 AS merch_ftg_30d
FROM main_data a
LEFT JOIN main_data b
    ON a.merchant_id = b.merchant_id
   AND b.unix_time < a.unix_time
   AND b.unix_time >= a.unix_time - (30 * 24 * 60 * 60)
GROUP BY
    a.txn_key,
    a.merchant_id,
    a.unix_time;
    
SELECT COUNT(*) FROM merch_ftg;
