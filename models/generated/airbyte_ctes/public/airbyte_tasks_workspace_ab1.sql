{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_tasks') }}
select
    _airbyte_airbyte_tasks_hashid,
    {{ json_extract_scalar('workspace', ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar('workspace', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('workspace', ['resource_type'], ['resource_type']) }} as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_tasks') }} as table_alias
-- workspace at airbyte_tasks/workspace
where 1 = 1
and workspace is not null

