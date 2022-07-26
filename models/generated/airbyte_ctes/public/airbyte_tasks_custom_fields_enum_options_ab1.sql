{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_tasks_custom_fields') }}
{{ unnest_cte(ref('airbyte_tasks_custom_fields'), 'custom_fields', 'enum_options') }}
select
    _airbyte_custom_fields_hashid,
    {{ json_extract_scalar(unnested_column_value('enum_options'), ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar(unnested_column_value('enum_options'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar(unnested_column_value('enum_options'), ['color'], ['color']) }} as color,
    {{ json_extract_scalar(unnested_column_value('enum_options'), ['enabled'], ['enabled']) }} as enabled,
    {{ json_extract_scalar(unnested_column_value('enum_options'), ['resource_type'], ['resource_type']) }} as resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_tasks_custom_fields') }} as table_alias
-- enum_options at airbyte_tasks/custom_fields/enum_options
{{ cross_join_unnest('custom_fields', 'enum_options') }}
where 1 = 1
and enum_options is not null

