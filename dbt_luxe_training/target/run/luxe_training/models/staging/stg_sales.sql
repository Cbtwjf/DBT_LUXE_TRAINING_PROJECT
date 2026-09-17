
  create or replace   view luxe_training.dwh.stg_sales
  
   as (
    select sale_id, sale_date, product_id, store_id, customer_id, channel, quantity, unit_price, sales_amount from LUXE_TRAINING.RAW.sales
  );

