{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('airbyte_users') }}
select
    _airbyte_airbyte_users_hashid,
    {{ json_extract_scalar('photo', ['image_21x21'], ['image_21x21']) }} as image_21x21,
    {{ json_extract_scalar('photo', ['image_27x27'], ['image_27x27']) }} as image_27x27,
    {{ json_extract_scalar('photo', ['image_36x36'], ['image_36x36']) }} as image_36x36,
    {{ json_extract_scalar('photo', ['image_60x60'], ['image_60x60']) }} as image_60x60,
    {{ json_extract_scalar('photo', ['image_128x128'], ['image_128x128']) }} as image_128x128,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('airbyte_users') }} as table_alias
-- photo at airbyte_users/photo
where 1 = 1
and photo is not null

