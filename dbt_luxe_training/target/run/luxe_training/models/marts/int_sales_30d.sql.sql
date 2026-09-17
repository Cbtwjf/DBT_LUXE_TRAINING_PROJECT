
  
    

        create or replace transient table luxe_training.dwh.int_sales_30d.sql
         as
        (SELECT
    product_id,
    store_id,
    SUM(quantity) AS qty_sold_30d,
    SUM(quantity) / 30.0 AS avg_daily_sales

FROM luxe_training.dwh.stg_sales

WHERE sale_date >= DATEADD(day, -30, CURRENT_DATE())

GROUP BY
    product_id,
    store_id
        );
      
  