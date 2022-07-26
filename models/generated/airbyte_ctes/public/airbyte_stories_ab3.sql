{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_stories_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'gid',
        adapter.quote('text'),
        adapter.quote('type'),
        'created_at',
        object_to_string('created_by'),
        'resource_type',
        'resource_subtype',
    ]) }} as _airbyte_airbyte_stories_hashid,
    tmp.*
from {{ ref('airbyte_stories_ab2') }} tmp
-- airbyte_stories
where 1 = 1

