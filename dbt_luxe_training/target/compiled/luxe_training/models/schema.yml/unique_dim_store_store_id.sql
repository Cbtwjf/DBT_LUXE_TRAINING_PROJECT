
    
    

select
    store_id as unique_field,
    count(*) as n_records

from luxe_training.dwh.dim_store
where store_id is not null
group by store_id
having count(*) > 1


