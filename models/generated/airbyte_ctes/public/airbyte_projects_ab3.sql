{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_projects_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'gid',
        'icon',
        adapter.quote('name'),
        object_to_string('team'),
        'color',
        'notes',
        object_to_string(adapter.quote('owner')),
        'due_on',
        boolean_to_string('public'),
        array_to_string('members'),
        boolean_to_string('archived'),
        'due_date',
        'start_on',
        array_to_string('followers'),
        object_to_string('workspace'),
        'created_at',
        'html_notes',
        boolean_to_string('is_template'),
        'modified_at',
        'default_view',
        array_to_string('custom_fields'),
        'permalink_url',
        'resource_type',
        object_to_string('current_status'),
        array_to_string('custom_field_settings'),
    ]) }} as _airbyte_airbyte_projects_hashid,
    tmp.*
from {{ ref('airbyte_projects_ab2') }} tmp
-- airbyte_projects
where 1 = 1

