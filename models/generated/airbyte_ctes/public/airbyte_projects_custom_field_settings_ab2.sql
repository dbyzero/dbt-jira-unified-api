{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_projects_custom_field_settings_ab1') }}
select
    _airbyte_airbyte_projects_hashid,
    cast(gid as {{ dbt_utils.type_string() }}) as gid,
    cast(resource_type as {{ dbt_utils.type_string() }}) as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_projects_custom_field_settings_ab1') }}
-- custom_field_settings at airbyte_projects/custom_field_settings
where 1 = 1

