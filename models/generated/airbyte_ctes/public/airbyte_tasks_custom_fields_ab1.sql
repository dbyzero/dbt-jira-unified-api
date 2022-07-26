{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_tasks') }}
{{ unnest_cte(ref('airbyte_tasks'), 'airbyte_tasks', 'custom_fields') }}
select
    _airbyte_airbyte_tasks_hashid,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['gid'], ['gid']) }} as gid,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['format'], ['format']) }} as {{ adapter.quote('format') }},
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['enabled'], ['enabled']) }} as enabled,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['precision'], ['precision']) }} as {{ adapter.quote('precision') }},
    {{ json_extract('', unnested_column_value('custom_fields'), ['created_by'], ['created_by']) }} as created_by,
    {{ json_extract('', unnested_column_value('custom_fields'), ['enum_value'], ['enum_value']) }} as enum_value,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['text_value'], ['text_value']) }} as text_value,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['description'], ['description']) }} as description,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['custom_label'], ['custom_label']) }} as custom_label,
    {{ json_extract_array(unnested_column_value('custom_fields'), ['enum_options'], ['enum_options']) }} as enum_options,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['number_value'], ['number_value']) }} as number_value,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['currency_code'], ['currency_code']) }} as currency_code,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['display_value'], ['display_value']) }} as display_value,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['resource_type'], ['resource_type']) }} as resource_type,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['resource_subtype'], ['resource_subtype']) }} as resource_subtype,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['custom_label_position'], ['custom_label_position']) }} as custom_label_position,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['is_global_to_workspace'], ['is_global_to_workspace']) }} as is_global_to_workspace,
    {{ json_extract_scalar(unnested_column_value('custom_fields'), ['has_notifications_enabled'], ['has_notifications_enabled']) }} as has_notifications_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_tasks') }} as table_alias
-- custom_fields at airbyte_tasks/custom_fields
{{ cross_join_unnest('airbyte_tasks', 'custom_fields') }}
where 1 = 1
and custom_fields is not null

