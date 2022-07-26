{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_tasks_custom_fields_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_airbyte_tasks_hashid',
        'gid',
        adapter.quote('name'),
        adapter.quote('type'),
        adapter.quote('format'),
        boolean_to_string('enabled'),
        adapter.quote('precision'),
        object_to_string('created_by'),
        object_to_string('enum_value'),
        'text_value',
        'description',
        'custom_label',
        array_to_string('enum_options'),
        'number_value',
        'currency_code',
        'display_value',
        'resource_type',
        'resource_subtype',
        'custom_label_position',
        boolean_to_string('is_global_to_workspace'),
        boolean_to_string('has_notifications_enabled'),
    ]) }} as _airbyte_custom_fields_hashid,
    tmp.*
from {{ ref('airbyte_tasks_custom_fields_ab2') }} tmp
-- custom_fields at airbyte_tasks/custom_fields
where 1 = 1

