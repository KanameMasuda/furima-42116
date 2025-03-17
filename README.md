# furima-42116 テーブル設計

## users テーブル

|Column                 | Type   | Options             |
| --------------------- | ------ | ------------------- |
| email                 | string | NOT NULL,ユニーク制約 |
| encrypted_password    | string | NOT NULL            |
| nickname              | string | NOT NULL            |
| last_name             | string | NOT NULL            |
| first_name            | string | NOT NULL            |
| last_name_kana        | string | NOT NULL            |
| first_name_kana       | string | NOT NULL            |
| birth_date            | date   | NOT NULL            |

### Association

- has_many :item
- has_many :order


## items テーブル

|Column                 | Type       | Options             |
| --------------------- | ---------- | ------------------- |
| name                  | string     | NOT NULL            |
| description           | text       | NOT NULL            |
| category_id           | integer    | NOT NULL            |
| condition_id          | integer    | NOT NULL            |
| shipping_fee_id       | integer    | NOT NULL            |
| prefecture_id         | integer    | NOT NULL            |
| shipping_days_id      | integer    | NOT NULL            |
| price                 | integer    | NOT NULL            |
| user                  | references | NOT NULL,外部キー    |


### Association

- belongs_to :user
- has_one :order


## orders テーブル

|Column                 | Type       | Options             |
| --------------------- | ---------- | ------------------- |
| user                  | references | NOT NULL,外部キー    |
| item                  | references | NOT NULL,外部キー    |
| address               | references | NOT NULL,外部キー    |
| payment_method_id     | integer    | NOT NULL            |
| payment_method_id     | string     | NOT NULL            |
| paid_at               | datetime   | NOT NULL            |
| shipped_at            | datetime   | NOT NULL            |
| delivered_at          | datetime   | NOT NULL            |


### Association

- belongs_to :item
- has_one :address


## addresses テーブル

|Column                 | Type       | Options             |
| --------------------- | ---------- | ------------------- |
| postal_code           | string     | NOT NULL            |
| prefecture_id         | integer    | NOT NULL            |
| city                  | string     | NOT NULL            |
| street_address        | string     | NOT NULL            |
| building_name         | string     |                     |
| phone_number          | string     | NOT NULL            |
| order                 | references | NOT NULL,外部キー    |

### Association

- belongs_to :oder