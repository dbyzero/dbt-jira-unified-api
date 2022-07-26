{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_tasks') }}
{{ unnest_cte(ref('airbyte_tasks'), 'airbyte_tasks', 'memberships') }}
select
    _airbyte_airbyte_tasks_hashid,
    {{ json_extract('', unnested_column_value('memberships'), ['project'], ['project']) }} as project,
    {{ json_extract('', unnested_column_value('memberships'), ['section'], ['section']) }} as {{ adapter.quote('section') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_tasks') }} as table_alias
-- memberships at airbyte_tasks/memberships
{{ cross_join_unnest('airbyte_tasks', 'memberships') }}
where 1 = 1
and memberships is not null

