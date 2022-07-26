{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_tasks_memberships_project_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_memberships_hashid',
        'gid',
        adapter.quote('name'),
        'resource_type',
    ]) }} as _airbyte_project_hashid,
    tmp.*
from {{ ref('airbyte_tasks_memberships_project_ab2') }} tmp
-- project at airbyte_tasks/memberships/project
where 1 = 1

