{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_projects_workspace_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_airbyte_projects_hashid',
        'gid',
        adapter.quote('name'),
        'resource_type',
    ]) }} as _airbyte_workspace_hashid,
    tmp.*
from {{ ref('airbyte_projects_workspace_ab2') }} tmp
-- workspace at airbyte_projects/workspace
where 1 = 1

