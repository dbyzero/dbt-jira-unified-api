{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_projects') }}
select
    _airbyte_airbyte_projects_hashid,
    {{ json_extract_scalar('current_status', ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar('current_status', ['text'], ['text']) }} as {{ adapter.quote('text') }},
    {{ json_extract_scalar('current_status', ['color'], ['color']) }} as color,
    {{ json_extract_scalar('current_status', ['title'], ['title']) }} as title,
    {{ json_extract('table_alias', 'current_status', ['author'], ['author']) }} as author,
    {{ json_extract_scalar('current_status', ['html_text'], ['html_text']) }} as html_text,
    {{ json_extract_scalar('current_status', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract('table_alias', 'current_status', ['created_by'], ['created_by']) }} as created_by,
    {{ json_extract_scalar('current_status', ['modified_at'], ['modified_at']) }} as modified_at,
    {{ json_extract_scalar('current_status', ['resource_type'], ['resource_type']) }} as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_projects') }} as table_alias
-- current_status at airbyte_projects/current_status
where 1 = 1
and current_status is not null

