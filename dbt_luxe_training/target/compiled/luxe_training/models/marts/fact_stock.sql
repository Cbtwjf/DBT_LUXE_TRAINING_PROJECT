SELECT
    i.product_id,
    i.store_id,
    i.stock_qty,

    s1.qty_sold_30d,
    s1.avg_daily_sales,
    s1.stock_coverage_days,

    s2.days_observed,
    s2.stockout_days,
    s2.stockout_rate

FROM luxe_training.dwh.int_inventory_current i

LEFT JOIN luxe_training.dwh.fact_stock_coverage s1
    ON i.product_id = s1.product_id
    AND i.store_id = s1.store_id

LEFT JOIN luxe_training.dwh.fact_stockout_rate s2
    ON i.product_id = s2.product_id
    AND i.store_id = s2.store_id