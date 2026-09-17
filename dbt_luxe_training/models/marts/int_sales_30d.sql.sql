SELECT
    product_id,
    store_id,
    SUM(quantity) AS qty_sold_30d,
    SUM(quantity) / 30.0 AS avg_daily_sales

FROM {{ ref('stg_sales') }}

WHERE sale_date >= DATEADD(day, -30, CURRENT_DATE())

GROUP BY
    product_id,
    store_idselect * from {{ ref('stg_sales') }}