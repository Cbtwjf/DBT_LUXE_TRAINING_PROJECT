
  
    
    
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
                F.col("STOCK_QTY")
                / F.col("AVG_DAILY_SALES")
            ).otherwise(F.lit(None))
        )
    )

    return result


# This part is user provided model code
# you will need to copy the next section to run the code
# COMMAND ----------
# this part is dbt logic for get ref work, do not modify

def ref(*args, **kwargs):
    refs = {"int_inventory_current": "luxe_training.dwh.int_inventory_current", "int_sales_30d": "luxe_training.dwh.int_sales_30d"}
    key = '.'.join(args)
    version = kwargs.get("v") or kwargs.get("version")
    if version:
        key += f".v{version}"
    dbt_load_df_function = kwargs.get("dbt_load_df_function")
    return dbt_load_df_function(refs[key])


def source(*args, dbt_load_df_function):
    sources = {}
    key = '.'.join(args)
    return dbt_load_df_function(sources[key])


config_dict = {}


class config:
    def __init__(self, *args, **kwargs):
        pass

    @staticmethod
    def get(key, default=None):
        return config_dict.get(key, default)

class this:
    """dbt.this() or dbt.this.identifier"""
    database = "luxe_training"
    schema = "dwh"
    identifier = "fact_stock_coverage2"
    
    def __repr__(self):
        return 'luxe_training.dwh.fact_stock_coverage2'


class dbtObj:
    def __init__(self, load_df_function) -> None:
        self.source = lambda *args: source(*args, dbt_load_df_function=load_df_function)
        self.ref = lambda *args, **kwargs: ref(*args, **kwargs, dbt_load_df_function=load_df_function)
        self.config = config
        self.this = this()
        self.is_incremental = False

# COMMAND ----------



def materialize(session, df, target_relation):
    # make sure pandas exists
    import importlib.util
    package_name = 'pandas'
    if importlib.util.find_spec(package_name):
        import pandas
        if isinstance(df, pandas.core.frame.DataFrame):
          session.use_database(target_relation.database)
          session.use_schema(target_relation.schema)
          # session.write_pandas does not have overwrite function
          df = session.createDataFrame(df)
    
    df.write.mode("overwrite").save_as_table('luxe_training.dwh.fact_stock_coverage2', table_type='transient')

def main(session):
    dbt = dbtObj(session.table)
    df = model(dbt, session)
    materialize(session, df, dbt.this)
    return "OK"

  