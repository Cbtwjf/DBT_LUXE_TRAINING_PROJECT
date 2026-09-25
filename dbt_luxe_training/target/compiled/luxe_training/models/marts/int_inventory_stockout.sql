SELECT
    snapshot_date date,
    product_id,
    store_id,
    stock_qty stock_quantity,

    CASE
        WHEN stock_qty = 0 THEN 1
        ELSE 0
    END AS is_stockout

FROM luxe_training.dwh.fact_inventory