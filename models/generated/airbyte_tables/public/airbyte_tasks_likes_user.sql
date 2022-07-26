{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_tasks_likes_user_ab3') }}
select
    _airbyte_likes_hashid,
    gid,
    {{ adapter.quote('name') }},
    resource_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_hashid
from {{ ref('airbyte_tasks_likes_user_ab3') }}
-- user at airbyte_tasks/likes/user from {{ ref('airbyte_tasks_likes') }}
where 1 = 1

