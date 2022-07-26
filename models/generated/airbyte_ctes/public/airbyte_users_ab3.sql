{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_users_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'gid',
        adapter.quote('name'),
        'email',
        object_to_string('photo'),
        array_to_string('workspaces'),
        'resource_type',
    ]) }} as _airbyte_airbyte_users_hashid,
    tmp.*
from {{ ref('airbyte_users_ab2') }} tmp
-- airbyte_users
where 1 = 1

