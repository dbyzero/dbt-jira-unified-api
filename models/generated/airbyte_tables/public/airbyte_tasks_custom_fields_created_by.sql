{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_tasks_custom_fields_created_by_ab3') }}
select
    _airbyte_custom_fields_hashid,
    gid,
    {{ adapter.quote('name') }},
    resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_created_by_hashid
from {{ ref('airbyte_tasks_custom_fields_created_by_ab3') }}
-- created_by at airbyte_tasks/custom_fields/created_by from {{ ref('airbyte_tasks_custom_fields') }}
where 1 = 1

