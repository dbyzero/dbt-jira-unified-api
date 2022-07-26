{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_tasks_memberships') }}
select
    _airbyte_memberships_hashid,
    {{ json_extract_scalar(adapter.quote('section'), ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar(adapter.quote('section'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar(adapter.quote('section'), ['resource_type'], ['resource_type']) }} as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_tasks_memberships') }} as table_alias
-- section at airbyte_tasks/memberships/section
where 1 = 1
and {{ adapter.quote('section') }} is not null

