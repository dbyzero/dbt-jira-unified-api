{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_projects_ab3') }}
select
    gid,
    icon,
    {{ adapter.quote('name') }},
    team,
    color,
    notes,
    {{ adapter.quote('owner') }},
    due_on,
    public,
    members,
    archived,
    due_date,
    start_on,
    followers,
    workspace,
    created_at,
    html_notes,
    is_template,
    modified_at,
    default_view,
    custom_fields,
    permalink_url,
    resource_type,
    current_status,
    custom_field_settings,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_projects_hashid
from {{ ref('airbyte_projects_ab3') }}
-- airbyte_projects from {{ source('public', '_airbyte_raw_airbyte_projects') }}
where 1 = 1

