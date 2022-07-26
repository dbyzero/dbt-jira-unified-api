{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('airbyte_tasks_ab1') }}
select
    cast(gid as {{ dbt_utils.type_string() }}) as gid,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    tags,
    {{ cast_to_boolean('liked') }} as liked,
    likes,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast({{ empty_string_to_null('due_at') }} as {{ type_timestamp_with_timezone() }}) as due_at,
    cast({{ empty_string_to_null('due_on') }} as {{ type_date() }}) as due_on,
    hearts,
    cast(parent as {{ type_json() }}) as parent,
    {{ cast_to_boolean('hearted') }} as hearted,
    cast(assignee as {{ type_json() }}) as assignee,
    cast({{ adapter.quote('external') }} as {{ type_json() }}) as {{ adapter.quote('external') }},
    projects,
    cast({{ empty_string_to_null('start_on') }} as {{ type_date() }}) as start_on,
    {{ cast_to_boolean('completed') }} as completed,
    followers,
    cast(num_likes as {{ dbt_utils.type_bigint() }}) as num_likes,
    cast(workspace as {{ type_json() }}) as workspace,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    dependents,
    cast(html_notes as {{ dbt_utils.type_string() }}) as html_notes,
    cast(num_hearts as {{ dbt_utils.type_bigint() }}) as num_hearts,
    memberships,
    cast({{ empty_string_to_null('modified_at') }} as {{ type_timestamp_with_timezone() }}) as modified_at,
    cast({{ empty_string_to_null('completed_at') }} as {{ type_timestamp_with_timezone() }}) as completed_at,
    cast(completed_by as {{ type_json() }}) as completed_by,
    dependencies,
    cast(num_subtasks as {{ dbt_utils.type_bigint() }}) as num_subtasks,
    custom_fields,
    cast(permalink_url as {{ dbt_utils.type_string() }}) as permalink_url,
    cast(resource_type as {{ dbt_utils.type_string() }}) as resource_type,
    cast(approval_status as {{ dbt_utils.type_string() }}) as approval_status,
    cast(resource_subtype as {{ dbt_utils.type_string() }}) as resource_subtype,
    {{ cast_to_boolean('is_rendered_as_separator') }} as is_rendered_as_separator,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_tasks_ab1') }}
-- airbyte_tasks
where 1 = 1

