
  
    

        create or replace transient table luxe_training.dwh.fact_stock_coverage
         as
        (SELECT
    i.product_id,
    i.store_id,
    i.stock_qty,
    s.qty_sold_30d,
    s.avg_daily_sales,

    CASE
        WHEN s.avg_daily_sales > 0
        THEN i.stock_qty / s.avg_daily_sales
        ELSE NULL
    END AS stock_coverage_days

FROM luxe_training.dwh.int_inventory_current i

LEFT JOIN luxe_training.dwh.int_sales_30d s
    ON i.product_id = s.product_id
    AND i.store_id = s.store_id
        );
      
  