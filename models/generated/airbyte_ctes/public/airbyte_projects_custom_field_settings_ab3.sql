{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_projects_custom_field_settings_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_airbyte_projects_hashid',
        'gid',
        'resource_type',
    ]) }} as _airbyte_custom_field_settings_hashid,
    tmp.*
from {{ ref('airbyte_projects_custom_field_settings_ab2') }} tmp
-- custom_field_settings at airbyte_projects/custom_field_settings
where 1 = 1

