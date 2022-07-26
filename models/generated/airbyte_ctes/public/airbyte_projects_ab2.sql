{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_projects_ab1') }}
select
    cast(gid as {{ dbt_utils.type_string() }}) as gid,
    cast(icon as {{ dbt_utils.type_string() }}) as icon,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(team as {{ type_json() }}) as team,
    cast(color as {{ dbt_utils.type_string() }}) as color,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast({{ adapter.quote('owner') }} as {{ type_json() }}) as {{ adapter.quote('owner') }},
    cast({{ empty_string_to_null('due_on') }} as {{ type_date() }}) as due_on,
    {{ cast_to_boolean('public') }} as public,
    members,
    {{ cast_to_boolean('archived') }} as archived,
    cast({{ empty_string_to_null('due_date') }} as {{ type_date() }}) as due_date,
    cast({{ empty_string_to_null('start_on') }} as {{ type_date() }}) as start_on,
    followers,
    cast(workspace as {{ type_json() }}) as workspace,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(html_notes as {{ dbt_utils.type_string() }}) as html_notes,
    {{ cast_to_boolean('is_template') }} as is_template,
    cast({{ empty_string_to_null('modified_at') }} as {{ type_timestamp_with_timezone() }}) as modified_at,
    cast(default_view as {{ dbt_utils.type_string() }}) as default_view,
    custom_fields,
    cast(permalink_url as {{ dbt_utils.type_string() }}) as permalink_url,
    cast(resource_type as {{ dbt_utils.type_string() }}) as resource_type,
    cast(current_status as {{ type_json() }}) as current_status,
    custom_field_settings,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_projects_ab1') }}
-- airbyte_projects
where 1 = 1

