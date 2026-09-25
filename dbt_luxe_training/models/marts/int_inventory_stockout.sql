SELECT
    date,
    product_id,
    store_id,
    stock_quantity,

    CASE
        WHEN stock_quantity = 0 THEN 1
        ELSE 0
    END AS is_stockout

FROM {{ ref('fact_inventory') }}