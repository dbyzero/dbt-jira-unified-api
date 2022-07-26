{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_users_workspaces_ab3') }}
select
    _airbyte_airbyte_users_hashid,
    gid,
    {{ adapter.quote('name') }},
    resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_workspaces_hashid
from {{ ref('airbyte_users_workspaces_ab3') }}
-- workspaces at airbyte_users/workspaces from {{ ref('airbyte_users') }}
where 1 = 1

