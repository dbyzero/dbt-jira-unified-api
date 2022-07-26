{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_airbyte_projects') }}
select
    {{ json_extract_scalar('_airbyte_data', ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar('_airbyte_data', ['icon'], ['icon']) }} as icon,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract('table_alias', '_airbyte_data', ['team'], ['team']) }} as team,
    {{ json_extract_scalar('_airbyte_data', ['color'], ['color']) }} as color,
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract('table_alias', '_airbyte_data', ['owner'], ['owner']) }} as {{ adapter.quote('owner') }},
    {{ json_extract_scalar('_airbyte_data', ['due_on'], ['due_on']) }} as due_on,
    {{ json_extract_scalar('_airbyte_data', ['public'], ['public']) }} as public,
    {{ json_extract_array('_airbyte_data', ['members'], ['members']) }} as members,
    {{ json_extract_scalar('_airbyte_data', ['archived'], ['archived']) }} as archived,
    {{ json_extract_scalar('_airbyte_data', ['due_date'], ['due_date']) }} as due_date,
    {{ json_extract_scalar('_airbyte_data', ['start_on'], ['start_on']) }} as start_on,
    {{ json_extract_array('_airbyte_data', ['followers'], ['followers']) }} as followers,
    {{ json_extract('table_alias', '_airbyte_data', ['workspace'], ['workspace']) }} as workspace,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['html_notes'], ['html_notes']) }} as html_notes,
    {{ json_extract_scalar('_airbyte_data', ['is_template'], ['is_template']) }} as is_template,
    {{ json_extract_scalar('_airbyte_data', ['modified_at'], ['modified_at']) }} as modified_at,
    {{ json_extract_scalar('_airbyte_data', ['default_view'], ['default_view']) }} as default_view,
    {{ json_extract_array('_airbyte_data', ['custom_fields'], ['custom_fields']) }} as custom_fields,
    {{ json_extract_scalar('_airbyte_data', ['permalink_url'], ['permalink_url']) }} as permalink_url,
    {{ json_extract_scalar('_airbyte_data', ['resource_type'], ['resource_type']) }} as resource_type,
    {{ json_extract('table_alias', '_airbyte_data', ['current_status'], ['current_status']) }} as current_status,
    {{ json_extract_array('_airbyte_data', ['custom_field_settings'], ['custom_field_settings']) }} as custom_field_settings,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_airbyte_projects') }} as table_alias
-- airbyte_projects
where 1 = 1

