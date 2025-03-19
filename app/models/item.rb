class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image  # 画像保存

extend ActiveHash::Associations::ActiveRecordExtensions
belongs_to :category
belongs_to :condition
belongs_to :shipping_fee
belongs_to :prefecture
belongs_to :shipping_days

validates :name, presence: true
validates :description, presence: true
validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
validates :image, presence: true

# ActiveHashのバリデーション（id: 1 は選択不可）

validates :category_id, numericality: { other_than: 1, message: "を選択してください" }
validates :condition_id, numericality: { other_than: 1, message: "を選択してください" }
validates :shipping_fee_id, numericality: { other_than: 1, message: "を選択してください" }
validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }
validates :shipping_days_id, numericality: { other_than: 1, message: "を選択してください" }
end
end
