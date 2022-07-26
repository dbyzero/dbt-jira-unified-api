{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_tasks_custom_fields') }}
select
    _airbyte_custom_fields_hashid,
    {{ json_extract_scalar('enum_value', ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar('enum_value', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('enum_value', ['color'], ['color']) }} as color,
    {{ json_extract_scalar('enum_value', ['enabled'], ['enabled']) }} as enabled,
    {{ json_extract_scalar('enum_value', ['resource_type'], ['resource_type']) }} as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_tasks_custom_fields') }} as table_alias
-- enum_value at airbyte_tasks/custom_fields/enum_value
where 1 = 1
and enum_value is not null

