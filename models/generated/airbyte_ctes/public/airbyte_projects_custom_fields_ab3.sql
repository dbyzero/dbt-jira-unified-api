{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_projects_custom_fields_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_airbyte_projects_hashid',
        'gid',
        adapter.quote('name'),
        adapter.quote('type'),
        boolean_to_string('enabled'),
        boolean_to_string('text_value'),
        array_to_string('enum_options'),
        'number_value',
        'display_value',
        'resource_type',
        'resource_subtype',
    ]) }} as _airbyte_custom_fields_hashid,
    tmp.*
from {{ ref('airbyte_projects_custom_fields_ab2') }} tmp
-- custom_fields at airbyte_projects/custom_fields
where 1 = 1

