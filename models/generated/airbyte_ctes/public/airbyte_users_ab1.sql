{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_airbyte_users') }}
select
    {{ json_extract_scalar('_airbyte_data', ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract('table_alias', '_airbyte_data', ['photo'], ['photo']) }} as photo,
    {{ json_extract_array('_airbyte_data', ['workspaces'], ['workspaces']) }} as workspaces,
    {{ json_extract_scalar('_airbyte_data', ['resource_type'], ['resource_type']) }} as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_airbyte_users') }} as table_alias
-- airbyte_users
where 1 = 1

