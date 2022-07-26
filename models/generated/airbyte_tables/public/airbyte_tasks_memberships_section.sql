{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_tasks_memberships_section_ab3') }}
select
    _airbyte_memberships_hashid,
    gid,
    {{ adapter.quote('name') }},
    resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_section_hashid
from {{ ref('airbyte_tasks_memberships_section_ab3') }}
-- section at airbyte_tasks/memberships/section from {{ ref('airbyte_tasks_memberships') }}
where 1 = 1

