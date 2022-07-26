{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_projects') }}
{{ unnest_cte(ref('airbyte_projects'), 'airbyte_projects', 'custom_fields') }}
select
    _airbyte_airbyte_projects_hashid,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['enabled'], ['enabled']) }} as enabled,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['text_value'], ['text_value']) }} as text_value,
    {{ json_extract_array(unnested_column_value('custom_fields'), ['enum_options'], ['enum_options']) }} as enum_options,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['number_value'], ['number_value']) }} as number_value,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['display_value'], ['display_value']) }} as display_value,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['resource_type'], ['resource_type']) }} as resource_type,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['resource_subtype'], ['resource_subtype']) }} as resource_subtype,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_projects') }} as table_alias
-- custom_fields at airbyte_projects/custom_fields
{{ cross_join_unnest('airbyte_projects', 'custom_fields') }}
where 1 = 1
and custom_fields is not null

