{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_tasks_hearts') }}
select
    _airbyte_hearts_hashid,
    {{ json_extract_scalar(adapter.quote('user'), ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar(adapter.quote('user'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar(adapter.quote('user'), ['resource_type'], ['resource_type']) }} as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_tasks_hearts') }} as table_alias
-- user at airbyte_tasks/hearts/user
where 1 = 1
and {{ adapter.quote('user') }} is not null

