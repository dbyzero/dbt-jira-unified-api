{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_tasks_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'gid',
        adapter.quote('name'),
        array_to_string('tags'),
        boolean_to_string('liked'),
        array_to_string('likes'),
        'notes',
        'due_at',
        'due_on',
        array_to_string('hearts'),
        object_to_string('parent'),
        boolean_to_string('hearted'),
        object_to_string('assignee'),
        object_to_string(adapter.quote('external')),
        array_to_string('projects'),
        'start_on',
        boolean_to_string('completed'),
        array_to_string('followers'),
        'num_likes',
        object_to_string('workspace'),
        'created_at',
        array_to_string('dependents'),
        'html_notes',
        'num_hearts',
        array_to_string('memberships'),
        'modified_at',
        'completed_at',
        object_to_string('completed_by'),
        array_to_string('dependencies'),
        'num_subtasks',
        array_to_string('custom_fields'),
        'permalink_url',
        'resource_type',
        'approval_status',
        'resource_subtype',
        boolean_to_string('is_rendered_as_separator'),
    ]) }} as _airbyte_airbyte_tasks_hashid,
    tmp.*
from {{ ref('airbyte_tasks_ab2') }} tmp
-- airbyte_tasks
where 1 = 1

