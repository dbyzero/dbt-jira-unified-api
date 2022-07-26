{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_tasks_likes_ab3') }}
select
    _airbyte_airbyte_tasks_hashid,
    gid,
    {{ adapter.quote('user') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_likes_hashid
from {{ ref('airbyte_tasks_likes_ab3') }}
-- likes at airbyte_tasks/likes from {{ ref('airbyte_tasks') }}
where 1 = 1

