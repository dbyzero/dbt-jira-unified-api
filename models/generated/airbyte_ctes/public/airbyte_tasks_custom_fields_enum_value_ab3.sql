{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_tasks_custom_fields_enum_value_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_custom_fields_hashid',
        'gid',
        adapter.quote('name'),
        'color',
        boolean_to_string('enabled'),
        'resource_type',
    ]) }} as _airbyte_enum_value_hashid,
    tmp.*
from {{ ref('airbyte_tasks_custom_fields_enum_value_ab2') }} tmp
-- enum_value at airbyte_tasks/custom_fields/enum_value
where 1 = 1

