{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_projects_team_ab3') }}
select
    _airbyte_airbyte_projects_hashid,
    gid,
    {{ adapter.quote('name') }},
    resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_team_hashid
from {{ ref('airbyte_projects_team_ab3') }}
-- team at airbyte_projects/team from {{ ref('airbyte_projects') }}
where 1 = 1

