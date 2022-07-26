{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_projects_team_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_airbyte_projects_hashid',
        'gid',
        adapter.quote('name'),
        'resource_type',
    ]) }} as _airbyte_team_hashid,
    tmp.*
from {{ ref('airbyte_projects_team_ab2') }} tmp
-- team at airbyte_projects/team
where 1 = 1

