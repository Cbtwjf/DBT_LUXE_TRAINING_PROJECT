select customer_id, first_name, last_name, country, segment from {{ source('raw','customers_dyn') }}
--test