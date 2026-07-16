DROP TABLE IF EXISTS cm_velocity;
CREATE TABLE cm_velocity AS
WITH base AS (
    SELECT
        txn_key,
        customer_id,
        unix_time,
        COUNT(*) OVER (
            PARTITION BY customer_id
            ORDER BY unix_time
            RANGE BETWEEN 86400 PRECEDING AND 1 PRECEDING
        ) AS cust_txn_cnt_24h
    FROM main_data
)
SELECT
    txn_key,
    customer_id,
    unix_time,
    cust_txn_cnt_24h,
    AVG(cust_txn_cnt_24h) OVER (
        PARTITION BY customer_id
        ORDER BY unix_time
        RANGE BETWEEN 2592000 PRECEDING AND 1 PRECEDING
    ) AS cust_txn_cnt_24h_avg_30d,
    cust_txn_cnt_24h / NULLIF(
        AVG(cust_txn_cnt_24h) OVER (
            PARTITION BY customer_id
            ORDER BY unix_time
            RANGE BETWEEN 2592000 PRECEDING AND 1 PRECEDING
        ), 0
    ) AS cust_velocity_ratio_30d
FROM base;gg
