DROP TABLE IF EXISTS merch_ftg;
CREATE TABLE merch_ftg AS
SELECT
    txn_key,
    merchant_id,
    unix_time,
    SUM(fraud_ind) OVER w AS merch_frd_txn_30d,
    COUNT(*) OVER w AS merch_tot_txn_30d,
    (SUM(fraud_ind) OVER w / NULLIF(COUNT(*) OVER w, 0)) * 100 AS merch_ftg_30d
FROM main_data
WINDOW w AS (
    PARTITION BY merchant_id
    ORDER BY unix_time
    RANGE BETWEEN 2592000 PRECEDING AND 1 PRECEDING
);

DROP TABLE IF EXISTS cat_ftg;
CREATE TABLE cat_ftg AS
SELECT
    txn_key,
    category,
    unix_time,
    SUM(fraud_ind) OVER w AS cat_frd_txn_30d,
    COUNT(*) OVER w AS cat_tot_txn_30d,
    (SUM(fraud_ind) OVER w / NULLIF(COUNT(*) OVER w, 0)) * 100 AS cat_ftg_30d
FROM main_data
WINDOW w AS (
    PARTITION BY category
    ORDER BY unix_time
    RANGE BETWEEN 2592000 PRECEDING AND 1 PRECEDING
);
