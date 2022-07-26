{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_stories_ab1') }}
select
    cast(gid as {{ dbt_utils.type_string() }}) as gid,
    cast({{ adapter.quote('text') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('text') }},
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(created_by as {{ type_json() }}) as created_by,
    cast(resource_type as {{ dbt_utils.type_string() }}) as resource_type,
    cast(resource_subtype as {{ dbt_utils.type_string() }}) as resource_subtype,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_stories_ab1') }}
-- airbyte_stories
where 1 = 1

