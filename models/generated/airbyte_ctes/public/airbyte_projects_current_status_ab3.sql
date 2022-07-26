{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_projects_current_status_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_airbyte_projects_hashid',
        'gid',
        adapter.quote('text'),
        'color',
        'title',
        object_to_string('author'),
        'html_text',
        'created_at',
        object_to_string('created_by'),
        'modified_at',
        'resource_type',
    ]) }} as _airbyte_current_status_hashid,
    tmp.*
from {{ ref('airbyte_projects_current_status_ab2') }} tmp
-- current_status at airbyte_projects/current_status
where 1 = 1

