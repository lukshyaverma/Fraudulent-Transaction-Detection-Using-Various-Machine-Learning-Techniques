DROP TABLE IF EXISTS cm_merch_good_hist;
CREATE TABLE cm_merch_good_hist AS
SELECT
    txn_key,
    COUNT(CASE WHEN fraud_ind = 0 THEN 1 END) OVER w AS cm_merch_good_txn_30d
FROM main_data
WINDOW w AS (
    PARTITION BY customer_id, merchant_id
    ORDER BY unix_time
    RANGE BETWEEN 2592000 PRECEDING AND 1 PRECEDING
);

DROP TABLE IF EXISTS cm_cat_good_hist;
CREATE TABLE cm_cat_good_hist AS
SELECT
    txn_key,
    COUNT(CASE WHEN fraud_ind = 0 THEN 1 END) OVER w AS cm_cat_good_txn_30d
FROM main_data
WINDOW w AS (
    PARTITION BY customer_id, category
    ORDER BY unix_time
    RANGE BETWEEN 2592000 PRECEDING AND 1 PRECEDING
);aa
