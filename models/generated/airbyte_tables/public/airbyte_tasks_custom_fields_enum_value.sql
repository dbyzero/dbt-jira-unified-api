{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_tasks_custom_fields_enum_value_ab3') }}
select
    _airbyte_custom_fields_hashid,
    gid,
    {{ adapter.quote('name') }},
    color,
    enabled,
    resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_enum_value_hashid
from {{ ref('airbyte_tasks_custom_fields_enum_value_ab3') }}
-- enum_value at airbyte_tasks/custom_fields/enum_value from {{ ref('airbyte_tasks_custom_fields') }}
where 1 = 1

