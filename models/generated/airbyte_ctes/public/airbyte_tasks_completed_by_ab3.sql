{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_tasks_completed_by_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_airbyte_tasks_hashid',
        'gid',
        adapter.quote('name'),
        'resource_type',
    ]) }} as _airbyte_completed_by_hashid,
    tmp.*
from {{ ref('airbyte_tasks_completed_by_ab2') }} tmp
-- completed_by at airbyte_tasks/completed_by
where 1 = 1

