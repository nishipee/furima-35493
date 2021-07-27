class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/, message: "is invalid. Include both letters and numbers" }

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "is invalid. Input full-width characters" } do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/, message: "is invalid. Input full-width katakana characters"} do
    validates :last_name_kana
    validates :first_name_kana
  end

  with_options presence: true do
    validates :nickname
    validates :birthday
  end

  has_many :products
  has_many :purchase_histories

end
