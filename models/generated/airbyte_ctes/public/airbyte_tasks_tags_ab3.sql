{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_tasks_tags_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_airbyte_tasks_hashid',
        'gid',
        adapter.quote('name'),
    ]) }} as _airbyte_tags_hashid,
    tmp.*
from {{ ref('airbyte_tasks_tags_ab2') }} tmp
-- tags at airbyte_tasks/tags
where 1 = 1

