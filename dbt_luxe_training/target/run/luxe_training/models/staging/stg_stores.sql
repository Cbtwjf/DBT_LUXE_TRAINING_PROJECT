
  create or replace   view luxe_training.dwh.stg_stores
  
   as (
    select store_id, store_name, city, country, store_type from LUXE_TRAINING.RAW.stores
  );

