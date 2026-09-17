
  create or replace   view luxe_training.dwh.stg_customers
  
   as (
    select customer_id, first_name, last_name, country, segment from LUXE_TRAINING.RAW.customers_dyn
--test
  );

