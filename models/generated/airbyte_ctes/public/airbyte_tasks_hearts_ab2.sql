{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_tasks_hearts_ab1') }}
select
    _airbyte_airbyte_tasks_hashid,
    cast(gid as {{ dbt_utils.type_string() }}) as gid,
    cast({{ adapter.quote('user') }} as {{ type_json() }}) as {{ adapter.quote('user') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_tasks_hearts_ab1') }}
-- hearts at airbyte_tasks/hearts
where 1 = 1

