class PurchaseHistoryAddress
  include ActiveModel::Model
  attr_accessor :token, :price, :postcode, :area_id, :city, :address, :building_name, :phone_num, :purchase_history_id, :user_id, :product_id

  with_options presence: true do
    validates :token
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
    validates :area_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_num, length: { maximum: 11 }, format: { with: /\A[0-9]+\z/, message: "is invalid. Input only number" }
    validates :user_id
    validates :product_id
  end

  def save
    purchase_history = PurchaseHistory.create(user_id: user_id, product_id: product_id)
    Address.create(postcode: postcode, area_id: area_id, city: city, address: address, building_name: building_name, phone_num: phone_num, purchase_history_id: purchase_history.id)
  end
end