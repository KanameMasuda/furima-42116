# furima-42116 テーブル設計

## users テーブル

|Column                 | Type   | Options                |
| --------------------- | ------ | ---------------------- |
| email                 | string | null: false,ユニーク制約 |
| encrypted_password    | string | null: false            |
| nickname              | string | null: false,ユニーク制約 |
| last_name             | string | null: false            |
| first_name            | string | null: false            |
| last_name_kana        | string | null: false            |
| first_name_kana       | string | null: false            |
| birth_date            | date   | null: false            |

### Association

- has_many :items
- has_many :orders


## items テーブル

|Column                 | Type       | Options             |
| --------------------- | ---------- | ------------------- |
| name                  | string     | null: false         |
| description           | text       | null: false         |
| category_id           | integer    | null: false         |
| condition_id          | integer    | null: false         |
| shipping_fee_id       | integer    | null: false         |
| prefecture_id         | integer    | null: false         |
| shipping_day_id       | integer    | null: false         |
| price                 | integer    | null: false         |
| user                  | references | null: false,外部キー |


### Association

- belongs_to :user
- has_one :order


## orders テーブル

|Column                 | Type       | Options             |
| --------------------- | ---------- | ------------------- |
| user                  | references | null: false,外部キー |
| item                  | references | null: false,外部キー |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address


## addresses テーブル

|Column                 | Type       | Options             |
| --------------------- | ---------- | ------------------- |
| postal_code           | string     | null: false         |
| prefecture_id         | integer    | null: false         |
| city                  | string     | null: false         |
| street_address        | string     | null: false         |
| building_name         | string     |                     |
| phone_number          | string     | null: false         |
| order                 | references | null: false,外部キー |

### Association

- belongs_to :order