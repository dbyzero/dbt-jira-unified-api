{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_projects_current_status_ab1') }}
select
    _airbyte_airbyte_projects_hashid,
    cast(gid as {{ dbt_utils.type_string() }}) as gid,
    cast({{ adapter.quote('text') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('text') }},
    cast(color as {{ dbt_utils.type_string() }}) as color,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(author as {{ type_json() }}) as author,
    cast(html_text as {{ dbt_utils.type_string() }}) as html_text,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(created_by as {{ type_json() }}) as created_by,
    cast({{ empty_string_to_null('modified_at') }} as {{ type_timestamp_with_timezone() }}) as modified_at,
    cast(resource_type as {{ dbt_utils.type_string() }}) as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_projects_current_status_ab1') }}
-- current_status at airbyte_projects/current_status
where 1 = 1

