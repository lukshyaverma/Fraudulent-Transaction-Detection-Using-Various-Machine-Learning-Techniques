DROP TABLE IF EXISTS cm_amount_oop;
CREATE TABLE cm_amount_oop AS
SELECT
    txn_key,
    customer_id,
    unix_time,
    amount,
    AVG(amount) OVER w AS cust_avg_amt_30d,
    MAX(amount) OVER w AS cust_max_amt_30d,
    amount / NULLIF(AVG(amount) OVER w, 0) AS cust_amt_vs_avg_ratio_30d,
    amount / NULLIF(MAX(amount) OVER w, 0) AS cust_amt_vs_max_ratio_30d
FROM main_data
WINDOW w AS (
    PARTITION BY customer_id
    ORDER BY unix_time
    RANGE BETWEEN 2592000 PRECEDING AND 1 PRECEDING
);
