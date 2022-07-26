{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_users_photo_ab1') }}
select
    _airbyte_airbyte_users_hashid,
    cast(image_21x21 as {{ dbt_utils.type_string() }}) as image_21x21,
    cast(image_27x27 as {{ dbt_utils.type_string() }}) as image_27x27,
    cast(image_36x36 as {{ dbt_utils.type_string() }}) as image_36x36,
    cast(image_60x60 as {{ dbt_utils.type_string() }}) as image_60x60,
    cast(image_128x128 as {{ dbt_utils.type_string() }}) as image_128x128,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_users_photo_ab1') }}
-- photo at airbyte_users/photo
where 1 = 1

