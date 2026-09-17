SELECT
    product_id,
    store_id,
    stock_qty

FROM luxe_training.dwh.stg_inventory

QUALIFY ROW_NUMBER() OVER (
    PARTITION BY product_id, store_id
    ORDER BY snapshot_date DESC
) = 1