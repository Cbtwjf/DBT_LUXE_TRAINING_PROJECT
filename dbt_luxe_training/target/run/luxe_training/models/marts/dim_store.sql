
  
    

        create or replace transient table luxe_training.dwh.dim_store
         as
        (select * from luxe_training.dwh.stg_stores
        );
      
  