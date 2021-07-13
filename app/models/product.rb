class Product < ApplicationRecord
  has_one_attached :image
  has_one :purchase_history
end
