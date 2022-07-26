{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_tasks_ab3') }}
select
    gid,
    {{ adapter.quote('name') }},
    tags,
    liked,
    likes,
    notes,
    due_at,
    due_on,
    hearts,
    parent,
    hearted,
    assignee,
    {{ adapter.quote('external') }},
    projects,
    start_on,
    completed,
    followers,
    num_likes,
    workspace,
    created_at,
    dependents,
    html_notes,
    num_hearts,
    memberships,
    modified_at,
    completed_at,
    completed_by,
    dependencies,
    num_subtasks,
    custom_fields,
    permalink_url,
    resource_type,
    approval_status,
    resource_subtype,
    is_rendered_as_separator,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_tasks_hashid
from {{ ref('airbyte_tasks_ab3') }}
-- airbyte_tasks from {{ source('public', '_airbyte_raw_airbyte_tasks') }}
where 1 = 1

