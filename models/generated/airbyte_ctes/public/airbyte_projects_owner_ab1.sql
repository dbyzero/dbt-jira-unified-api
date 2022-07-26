{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_projects') }}
select
    _airbyte_airbyte_projects_hashid,
    {{ json_extract_scalar(adapter.quote('owner'), ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar(adapter.quote('owner'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar(adapter.quote('owner'), ['resource_type'], ['resource_type']) }} as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_projects') }} as table_alias
-- owner at airbyte_projects/owner
where 1 = 1
and {{ adapter.quote('owner') }} is not null

