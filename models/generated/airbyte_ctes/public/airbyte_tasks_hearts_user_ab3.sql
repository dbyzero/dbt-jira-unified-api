{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_tasks_hearts_user_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_hearts_hashid',
        'gid',
        adapter.quote('name'),
        'resource_type',
    ]) }} as _airbyte_user_hashid,
    tmp.*
from {{ ref('airbyte_tasks_hearts_user_ab2') }} tmp
-- user at airbyte_tasks/hearts/user
where 1 = 1

