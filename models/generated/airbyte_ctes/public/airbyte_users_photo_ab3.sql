{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('airbyte_users_photo_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_airbyte_users_hashid',
        'image_21x21',
        'image_27x27',
        'image_36x36',
        'image_60x60',
        'image_128x128',
    ]) }} as _airbyte_photo_hashid,
    tmp.*
from {{ ref('airbyte_users_photo_ab2') }} tmp
-- photo at airbyte_users/photo
where 1 = 1

