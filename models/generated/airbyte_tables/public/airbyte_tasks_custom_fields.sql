{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_tasks_custom_fields_ab3') }}
select
    _airbyte_airbyte_tasks_hashid,
    gid,
    {{ adapter.quote('name') }},
    {{ adapter.quote('type') }},
    {{ adapter.quote('format') }},
    enabled,
    {{ adapter.quote('precision') }},
    created_by,
    enum_value,
    text_value,
    description,
    custom_label,
    enum_options,
    number_value,
    currency_code,
    display_value,
    resource_type,
    resource_subtype,
    custom_label_position,
    is_global_to_workspace,
    has_notifications_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_custom_fields_hashid
from {{ ref('airbyte_tasks_custom_fields_ab3') }}
-- custom_fields at airbyte_tasks/custom_fields from {{ ref('airbyte_tasks') }}
where 1 = 1

