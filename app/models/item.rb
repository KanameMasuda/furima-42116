class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image # 画像保存
  before_validation :set_default_sold_out

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_days

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'must be a number between 300 and 9,999,999' }
  validates :image, presence: true
  validates :sold_out, inclusion: { in: [true, false] }
  validates :category_id, presence: true, numericality: { other_than: 1, message: 'を選択してください' }
  validates :condition_id, presence: true, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_fee_id, presence: true, numericality: { other_than: 1, message: 'を選択してください' }
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_days_id, presence: true, numericality: { other_than: 1, message: 'を選択してください' }

  private

  def set_default_sold_out
    self.sold_out ||= false
  end
end
