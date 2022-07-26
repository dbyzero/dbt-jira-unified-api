{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_tasks') }}
{{ unnest_cte(ref('airbyte_tasks'), 'airbyte_tasks', 'likes') }}
select
    _airbyte_airbyte_tasks_hashid,
    {{ json_extract_scalar(unnested_column_value('likes'), ['gid'], ['gid']) }} as gid,
    {{ json_extract('', unnested_column_value('likes'), ['user'], ['user']) }} as {{ adapter.quote('user') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_tasks') }} as table_alias
-- likes at airbyte_tasks/likes
{{ cross_join_unnest('airbyte_tasks', 'likes') }}
where 1 = 1
and likes is not null

