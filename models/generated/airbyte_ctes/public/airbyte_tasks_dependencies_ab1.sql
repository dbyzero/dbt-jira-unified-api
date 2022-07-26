{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_tasks') }}
{{ unnest_cte(ref('airbyte_tasks'), 'airbyte_tasks', 'dependencies') }}
select
    _airbyte_airbyte_tasks_hashid,
    {{ json_extract_scalar(unnested_column_value('dependencies'), ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar(unnested_column_value('dependencies'), ['resource_type'], ['resource_type']) }} as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_tasks') }} as table_alias
-- dependencies at airbyte_tasks/dependencies
{{ cross_join_unnest('airbyte_tasks', 'dependencies') }}
where 1 = 1
and dependencies is not null

