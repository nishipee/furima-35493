class Product < ApplicationRecord
  has_one_attached :image
  has_one :purchase_history
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :area
  belongs_to :category
  belongs_to :charge
  belongs_to :scheduled_day
  belongs_to :status

  with_options presence: true, numericality: { other_than: 1, message: "can't be blank" } do
    validates :area_id
    validates :category_id
    validates :charge_id
    validates :scheduled_day_id
    validates :status_id
  end

  with_options presence: true do
    validates :image
    validates :name
    validates :introduction
  end
  
  validates :price, presence: true, inclusion: { in: 300..9_999_999, message: "is out of setting range"}
  validates :price, numericality: { with: /\A[0-9]+\z/, message: "is invalid. Input half-width characters" }
end
