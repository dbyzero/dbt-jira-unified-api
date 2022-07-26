{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_tasks_likes_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_airbyte_tasks_hashid',
        'gid',
        object_to_string(adapter.quote('user')),
    ]) }} as _airbyte_likes_hashid,
    tmp.*
from {{ ref('airbyte_tasks_likes_ab2') }} tmp
-- likes at airbyte_tasks/likes
where 1 = 1

