{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_projects_current_status_created_by_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_current_status_hashid',
        'gid',
        adapter.quote('name'),
        'resource_type',
    ]) }} as _airbyte_created_by_hashid,
    tmp.*
from {{ ref('airbyte_projects_current_status_created_by_ab2') }} tmp
-- created_by at airbyte_projects/current_status/created_by
where 1 = 1

