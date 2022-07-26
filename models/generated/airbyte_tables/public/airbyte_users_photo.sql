{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('airbyte_users_photo_ab3') }}
select
    _airbyte_airbyte_users_hashid,
    image_21x21,
    image_27x27,
    image_36x36,
    image_60x60,
    image_128x128,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_photo_hashid
from {{ ref('airbyte_users_photo_ab3') }}
-- photo at airbyte_users/photo from {{ ref('airbyte_users') }}
where 1 = 1

