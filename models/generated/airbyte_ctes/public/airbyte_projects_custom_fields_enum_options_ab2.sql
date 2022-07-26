{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_projects_custom_fields_enum_options_ab1') }}
select
    _airbyte_custom_fields_hashid,
    cast(gid as {{ dbt_utils.type_string() }}) as gid,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(color as {{ dbt_utils.type_string() }}) as color,
    {{ cast_to_boolean('enabled') }} as enabled,
    cast(resource_type as {{ dbt_utils.type_string() }}) as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_projects_custom_fields_enum_options_ab1') }}
-- enum_options at airbyte_projects/custom_fields/enum_options
where 1 = 1

