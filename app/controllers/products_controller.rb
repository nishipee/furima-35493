class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :move_to_index]
  before_action :move_to_index, only: [:edit, :update]
  

  def index
    @products = Product.includes(:user).order("created_at DESC")
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  
  private
  def product_params
    params.require(:product).permit(:image, :name, :introduction, :category_id, :status_id, :charge_id, :area_id, :scheduled_day_id, :price).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def move_to_index
    if @product.user != current_user #|| @product.purchase_history.present?
      redirect_to root_path
    end
  end
end