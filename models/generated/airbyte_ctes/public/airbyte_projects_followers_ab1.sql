{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_projects') }}
{{ unnest_cte(ref('airbyte_projects'), 'airbyte_projects', 'followers') }}
select
    _airbyte_airbyte_projects_hashid,
    {{ json_extract_scalar(unnested_column_value('followers'), ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar(unnested_column_value('followers'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar(unnested_column_value('followers'), ['resource_type'], ['resource_type']) }} as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_projects') }} as table_alias
-- followers at airbyte_projects/followers
{{ cross_join_unnest('airbyte_projects', 'followers') }}
where 1 = 1
and followers is not null

