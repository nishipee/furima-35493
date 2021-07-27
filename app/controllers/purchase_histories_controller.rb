class PurchaseHistoriesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    @purchase_history_address = PurchaseHistoryAddress.new
    @product = Product.find(params[:product_id])
  end

  def create
    @purchase_history_address = PurchaseHistoryAddress.new(purchase_history_address_params)
    if @purchase_history_address.valid?
      pay_item
      @purchase_history_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def purchase_history_address_params
    @product = Product.find(params[:product_id])
    params.require(:purchase_history_address).permit(:postcode, :area_id, :city, :address, :building_name, :phone_num).merge(user_id: current_user.id, product_id: params[:product_id], price: @product.price, token: params[:token])
  end

  def move_to_index
    @product = Product.find(params[:product_id])
    if current_user == @product.user || @product.purchase_history.present?
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: purchase_history_address_params[:price],
      card: purchase_history_address_params[:token],
      currency: "jpy"
    )
  end
end
