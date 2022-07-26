{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_tasks_external_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_airbyte_tasks_hashid',
        'gid',
        adapter.quote('data'),
    ]) }} as _airbyte_external_hashid,
    tmp.*
from {{ ref('airbyte_tasks_external_ab2') }} tmp
-- external at airbyte_tasks/external
where 1 = 1

