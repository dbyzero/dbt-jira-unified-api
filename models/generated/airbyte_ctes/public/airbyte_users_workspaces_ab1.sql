{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_users') }}
{{ unnest_cte(ref('airbyte_users'), 'airbyte_users', 'workspaces') }}
select
    _airbyte_airbyte_users_hashid,
    {{ json_extract_scalar(unnested_column_value('workspaces'), ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar(unnested_column_value('workspaces'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar(unnested_column_value('workspaces'), ['resource_type'], ['resource_type']) }} as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_users') }} as table_alias
-- workspaces at airbyte_users/workspaces
{{ cross_join_unnest('airbyte_users', 'workspaces') }}
where 1 = 1
and workspaces is not null

