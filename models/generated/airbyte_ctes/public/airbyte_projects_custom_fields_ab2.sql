{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_projects_custom_fields_ab1') }}
select
    _airbyte_airbyte_projects_hashid,
    cast(gid as {{ dbt_utils.type_string() }}) as gid,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    {{ cast_to_boolean('enabled') }} as enabled,
    {{ cast_to_boolean('text_value') }} as text_value,
    enum_options,
    cast(number_value as {{ dbt_utils.type_float() }}) as number_value,
    cast(display_value as {{ dbt_utils.type_string() }}) as display_value,
    cast(resource_type as {{ dbt_utils.type_string() }}) as resource_type,
    cast(resource_subtype as {{ dbt_utils.type_string() }}) as resource_subtype,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_projects_custom_fields_ab1') }}
-- custom_fields at airbyte_projects/custom_fields
where 1 = 1

