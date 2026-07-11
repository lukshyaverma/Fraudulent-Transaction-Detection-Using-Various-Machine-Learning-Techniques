create table main_data_01 as
    select 
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
            6371 * ACOS(
                COS(RADIANS(cust_lat))
                * COS(RADIANS(merch_lat))
                * COS(RADIANS(merch_long) - RADIANS(cust_long))
                + SIN(RADIANS(cust_lat))
                * SIN(RADIANS(merch_lat))
            )
        as cm_merch_dist,
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
        fraud_ind
    from main_data;

drop table main_data;
alter table main_data_01 rename to main_data;

select * from main_data limit 10;
