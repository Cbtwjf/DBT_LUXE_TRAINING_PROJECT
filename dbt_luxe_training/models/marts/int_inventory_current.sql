SELECT
    product_id,
    store_id,
    stock_available

FROM {{ ref('stg_inventory') }}

QUALIFY ROW_NUMBER() OVER (
    PARTITION BY product_id, store_id
    ORDER BY inventory_date DESC
) = 1