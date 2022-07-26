{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_tasks_memberships_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_airbyte_tasks_hashid',
        object_to_string('project'),
        object_to_string(adapter.quote('section')),
    ]) }} as _airbyte_memberships_hashid,
    tmp.*
from {{ ref('airbyte_tasks_memberships_ab2') }} tmp
-- memberships at airbyte_tasks/memberships
where 1 = 1

