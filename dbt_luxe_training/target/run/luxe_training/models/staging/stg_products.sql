
  create or replace   view luxe_training.dwh.stg_products
  
   as (
    select product_id, sku, category, collection, unit_price, supplier_name from LUXE_TRAINING.RAW.products
  );

