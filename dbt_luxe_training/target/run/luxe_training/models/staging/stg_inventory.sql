
  create or replace   view luxe_training.dwh.stg_inventory
  
   as (
    select snapshot_date, product_id, store_id, stock_qty, stock_in_transit from LUXE_TRAINING.RAW.inventory
  );

