
  
    

        create or replace transient table luxe_training.dwh.fact_inventory
         as
        (select * from luxe_training.dwh.stg_inventory
        );
      
  