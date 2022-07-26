{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_tasks_custom_fields') }}
select
    _airbyte_custom_fields_hashid,
    {{ json_extract_scalar('created_by', ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar('created_by', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('created_by', ['resource_type'], ['resource_type']) }} as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_tasks_custom_fields') }} as table_alias
-- created_by at airbyte_tasks/custom_fields/created_by
where 1 = 1
and created_by is not null

