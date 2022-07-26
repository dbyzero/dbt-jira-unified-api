{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_projects_custom_fields_enum_options_ab3') }}
select
    _airbyte_custom_fields_hashid,
    gid,
    {{ adapter.quote('name') }},
    color,
    enabled,
    resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_enum_options_hashid
from {{ ref('airbyte_projects_custom_fields_enum_options_ab3') }}
-- enum_options at airbyte_projects/custom_fields/enum_options from {{ ref('airbyte_projects_custom_fields') }}
where 1 = 1

