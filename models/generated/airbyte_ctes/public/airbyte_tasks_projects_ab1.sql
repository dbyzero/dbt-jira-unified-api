{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_tasks') }}
{{ unnest_cte(ref('airbyte_tasks'), 'airbyte_tasks', 'projects') }}
select
    _airbyte_airbyte_tasks_hashid,
    {{ json_extract_scalar(unnested_column_value('projects'), ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar(unnested_column_value('projects'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar(unnested_column_value('projects'), ['resource_type'], ['resource_type']) }} as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_tasks') }} as table_alias
-- projects at airbyte_tasks/projects
{{ cross_join_unnest('airbyte_tasks', 'projects') }}
where 1 = 1
and projects is not null

