{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_airbyte_stories') }}
select
    {{ json_extract_scalar('_airbyte_data', ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar('_airbyte_data', ['text'], ['text']) }} as {{ adapter.quote('text') }},
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract('table_alias', '_airbyte_data', ['created_by'], ['created_by']) }} as created_by,
    {{ json_extract_scalar('_airbyte_data', ['resource_type'], ['resource_type']) }} as resource_type,
    {{ json_extract_scalar('_airbyte_data', ['resource_subtype'], ['resource_subtype']) }} as resource_subtype,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_airbyte_stories') }} as table_alias
-- airbyte_stories
where 1 = 1

