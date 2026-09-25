SELECT
    product_id,
    store_id,

    COUNT(*) AS days_observed,

    SUM(is_stockout) AS stockout_days,

    ROUND(
        SUM(is_stockout) * 100.0 / COUNT(*),
        2
    ) AS stockout_rate

FROM luxe_training.dwh.int_inventory_stockout

GROUP BY
    product_id,
    store_id