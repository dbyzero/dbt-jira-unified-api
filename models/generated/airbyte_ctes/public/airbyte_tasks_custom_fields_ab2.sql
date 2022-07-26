{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_tasks_custom_fields_ab1') }}
select
    _airbyte_airbyte_tasks_hashid,
    cast(gid as {{ dbt_utils.type_string() }}) as gid,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    cast({{ adapter.quote('format') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('format') }},
    {{ cast_to_boolean('enabled') }} as enabled,
    cast({{ adapter.quote('precision') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('precision') }},
    cast(created_by as {{ type_json() }}) as created_by,
    cast(enum_value as {{ type_json() }}) as enum_value,
    cast(text_value as {{ dbt_utils.type_string() }}) as text_value,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(custom_label as {{ dbt_utils.type_string() }}) as custom_label,
    enum_options,
    cast(number_value as {{ dbt_utils.type_float() }}) as number_value,
    cast(currency_code as {{ dbt_utils.type_string() }}) as currency_code,
    cast(display_value as {{ dbt_utils.type_string() }}) as display_value,
    cast(resource_type as {{ dbt_utils.type_string() }}) as resource_type,
    cast(resource_subtype as {{ dbt_utils.type_string() }}) as resource_subtype,
    cast(custom_label_position as {{ dbt_utils.type_string() }}) as custom_label_position,
    {{ cast_to_boolean('is_global_to_workspace') }} as is_global_to_workspace,
    {{ cast_to_boolean('has_notifications_enabled') }} as has_notifications_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_tasks_custom_fields_ab1') }}
-- custom_fields at airbyte_tasks/custom_fields
where 1 = 1

