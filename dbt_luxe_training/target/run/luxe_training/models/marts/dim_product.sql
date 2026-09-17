
  
    

        create or replace transient table luxe_training.dwh.dim_product
         as
        (select * from luxe_training.dwh.stg_products
        );
      
  