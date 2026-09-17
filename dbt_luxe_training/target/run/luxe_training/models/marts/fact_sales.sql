
  
    

        create or replace transient table luxe_training.dwh.fact_sales
         as
        (select * from luxe_training.dwh.stg_sales
        );
      
  