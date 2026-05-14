WITH source AS ( 
    select * from {{ source('olist','olist_geolocation_dataset') }}
 ),

renamed as (
    select
    geolocation_zip_code_prefix,
    geolocation_city,
    geolocation_state
    from source
)
select * from renamed