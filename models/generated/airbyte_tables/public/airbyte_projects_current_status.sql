{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_projects_current_status_ab3') }}
select
    _airbyte_airbyte_projects_hashid,
    gid,
    {{ adapter.quote('text') }},
    color,
    title,
    author,
    html_text,
    created_at,
    created_by,
    modified_at,
    resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_current_status_hashid
from {{ ref('airbyte_projects_current_status_ab3') }}
-- current_status at airbyte_projects/current_status from {{ ref('airbyte_projects') }}
where 1 = 1

