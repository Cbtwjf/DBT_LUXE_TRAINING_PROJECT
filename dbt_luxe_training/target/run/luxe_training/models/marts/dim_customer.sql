
  
    

        create or replace transient table luxe_training.dwh.dim_customer
         as
        (select * from luxe_training.dwh.stg_customers
        );
      
  