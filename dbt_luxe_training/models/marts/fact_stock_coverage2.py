from snowflake.snowpark import functions as F


def model(dbt, session):

    dbt.config(
        materialized="table"
    )

    # Sources dbt
    inventory = dbt.ref("int_inventory_current")
    sales = dbt.ref("int_sales_30d")

    # Jointure stock + ventes
    result = (
        inventory
        .join(
            sales,
            ["PRODUCT_ID", "STORE_ID"],
            "left"
        )
        .with_column(
            "AVG_DAILY_SALES",
            F.coalesce(
                F.col("AVG_DAILY_SALES"),
                F.lit(0)
            )
        )
        .with_column(
            "STOCK_COVERAGE_DAYS",
            F.when(
                F.col("AVG_DAILY_SALES") > 0,
                F.col("STOCK_AVAILABLE")
                / F.col("AVG_DAILY_SALES")
            ).otherwise(F.lit(None))
        )
    )

    return result
