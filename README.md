# テーブル設計

## users テーブル

| Column              | Type   | Options                   |
| ------------------- | ------ | ------------------------- |
| nickname            | string | null: false               |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false               |
| last_name           | string | null: false               |
| first_name          | string | null: false               |
| last_name_kana      | string | null: false               |
| first_name_kana     | string | null: false               |
| birthday            | date   | null: false               |

### Association

- has_many :products
- has_many :purchase_histories


## purchase_histories テーブル

| Column  | Type       | Options           |
| ------- | ---------- | ----------------- |
| user    | references | foreign_key: true |
| product | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product
- has_one :address


## products テーブル

| Column           | Type       | Options           |
| ---------------- | ---------- | ----------------- |
| name             | string     | null: false       |
| introduction     | text       | null: false       |
| category_id      | integer    | null: false       |
| status_id        | integer    | null: false       |
| charge_id        | integer    | null: false       |
| area_id          | integer    | null: false       |
| scheduled_day_id | integer    | null: false       |
| price            | integer    | null: false       |
| user             | references | foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_history


## addresses テーブル

| Column           | Type       | Options           |
| ---------------- | ---------- | ----------------- |
| postcode         | string     | null: false       |
| area_id          | integer    | null: false       |
| city             | string     | null: false       |
| address          | string     | null: false       |
| building_name    | string     |                   |
| phone_num        | string     | null: false       |
| purchase_history | references | foreign_key: true |

### Association

- belongs_to :purchase_history
