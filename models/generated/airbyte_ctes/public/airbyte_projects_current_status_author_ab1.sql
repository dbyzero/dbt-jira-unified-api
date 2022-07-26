{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_projects_current_status') }}
select
    _airbyte_current_status_hashid,
    {{ json_extract_scalar('author', ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar('author', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('author', ['resource_type'], ['resource_type']) }} as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_projects_current_status') }} as table_alias
-- author at airbyte_projects/current_status/author
where 1 = 1
and author is not null

