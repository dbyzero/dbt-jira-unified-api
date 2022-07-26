{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_airbyte_tasks') }}
select
    {{ json_extract_scalar('_airbyte_data', ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_array('_airbyte_data', ['tags'], ['tags']) }} as tags,
    {{ json_extract_scalar('_airbyte_data', ['liked'], ['liked']) }} as liked,
    {{ json_extract_array('_airbyte_data', ['likes'], ['likes']) }} as likes,
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['due_at'], ['due_at']) }} as due_at,
    {{ json_extract_scalar('_airbyte_data', ['due_on'], ['due_on']) }} as due_on,
    {{ json_extract_array('_airbyte_data', ['hearts'], ['hearts']) }} as hearts,
    {{ json_extract('table_alias', '_airbyte_data', ['parent'], ['parent']) }} as parent,
    {{ json_extract_scalar('_airbyte_data', ['hearted'], ['hearted']) }} as hearted,
    {{ json_extract('table_alias', '_airbyte_data', ['assignee'], ['assignee']) }} as assignee,
    {{ json_extract('table_alias', '_airbyte_data', ['external'], ['external']) }} as {{ adapter.quote('external') }},
    {{ json_extract_array('_airbyte_data', ['projects'], ['projects']) }} as projects,
    {{ json_extract_scalar('_airbyte_data', ['start_on'], ['start_on']) }} as start_on,
    {{ json_extract_scalar('_airbyte_data', ['completed'], ['completed']) }} as completed,
    {{ json_extract_array('_airbyte_data', ['followers'], ['followers']) }} as followers,
    {{ json_extract_scalar('_airbyte_data', ['num_likes'], ['num_likes']) }} as num_likes,
    {{ json_extract('table_alias', '_airbyte_data', ['workspace'], ['workspace']) }} as workspace,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_array('_airbyte_data', ['dependents'], ['dependents']) }} as dependents,
    {{ json_extract_scalar('_airbyte_data', ['html_notes'], ['html_notes']) }} as html_notes,
    {{ json_extract_scalar('_airbyte_data', ['num_hearts'], ['num_hearts']) }} as num_hearts,
    {{ json_extract_array('_airbyte_data', ['memberships'], ['memberships']) }} as memberships,
    {{ json_extract_scalar('_airbyte_data', ['modified_at'], ['modified_at']) }} as modified_at,
    {{ json_extract_scalar('_airbyte_data', ['completed_at'], ['completed_at']) }} as completed_at,
    {{ json_extract('table_alias', '_airbyte_data', ['completed_by'], ['completed_by']) }} as completed_by,
    {{ json_extract_array('_airbyte_data', ['dependencies'], ['dependencies']) }} as dependencies,
    {{ json_extract_scalar('_airbyte_data', ['num_subtasks'], ['num_subtasks']) }} as num_subtasks,
    {{ json_extract_array('_airbyte_data', ['custom_fields'], ['custom_fields']) }} as custom_fields,
    {{ json_extract_scalar('_airbyte_data', ['permalink_url'], ['permalink_url']) }} as permalink_url,
    {{ json_extract_scalar('_airbyte_data', ['resource_type'], ['resource_type']) }} as resource_type,
    {{ json_extract_scalar('_airbyte_data', ['approval_status'], ['approval_status']) }} as approval_status,
    {{ json_extract_scalar('_airbyte_data', ['resource_subtype'], ['resource_subtype']) }} as resource_subtype,
    {{ json_extract_scalar('_airbyte_data', ['is_rendered_as_separator'], ['is_rendered_as_separator']) }} as is_rendered_as_separator,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_airbyte_tasks') }} as table_alias
-- airbyte_tasks
where 1 = 1

