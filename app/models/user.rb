class User < ApplicationRecord
  has_many :items
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :last_name, presence: true, format: {
    with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
    message: 'はひらがな・カタカナ・漢字のみ使用できます'
  }
  validates :first_name, presence: true, format: {
    with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
    message: 'はひらがな・カタカナ・漢字のみ使用できます'
  }
  validates :last_name_kana, presence: true, format: {
    with: /\A[ァ-ヶー]+\z/,
    message: 'はカタカナのみ使用できます'
  }
  validates :first_name_kana, presence: true, format: {
    with: /\A[ァ-ヶー]+\z/,
    message: 'はカタカナのみ使用できます'
  }
  validates :birth_date, presence: true
  validates :password, format: {
    with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
    message: 'は英数字を両方含める必要があります'
  }
end
