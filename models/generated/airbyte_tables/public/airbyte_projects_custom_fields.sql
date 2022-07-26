{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_projects_custom_fields_ab3') }}
select
    _airbyte_airbyte_projects_hashid,
    gid,
    {{ adapter.quote('name') }},
    {{ adapter.quote('type') }},
    enabled,
    text_value,
    enum_options,
    number_value,
    display_value,
    resource_type,
    resource_subtype,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_custom_fields_hashid
from {{ ref('airbyte_projects_custom_fields_ab3') }}
-- custom_fields at airbyte_projects/custom_fields from {{ ref('airbyte_projects') }}
where 1 = 1

