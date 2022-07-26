{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_stories_ab3') }}
select
    gid,
    {{ adapter.quote('text') }},
    {{ adapter.quote('type') }},
    created_at,
    created_by,
    resource_type,
    resource_subtype,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_airbyte_stories_hashid
from {{ ref('airbyte_stories_ab3') }}
-- airbyte_stories from {{ source('public', '_airbyte_raw_airbyte_stories') }}
where 1 = 1

