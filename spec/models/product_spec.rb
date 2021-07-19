require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe "新規商品出品" do
    context "新規商品を出品できるとき" do
      it "image,name,introduction,category_id,status_id,charge_id,area_id,scheduled_day_id,priceが存在すれば出品できる" do
        expect(@product).to be_valid
      end
      it "nameが40文字以下であれば出品できる" do
        @product.name = Faker::Lorem.sentence(40)
        expect(@product).to be_valid
      end
      it "introductionが1000文字以下であれば出品できる" do
        @product.introduction = Faker::Lorem.sentence(1000)
        expect(@product).to be_valid
      end
      it "category_id,status_id,charge_id,area_id,scheduled_day_id,が1以外であれば登録できる" do
        @product.category_id = 2
        @product.status_id = 2
        @product.charge_id = 2
        @product.area_id = 2
        @product.scheduled_day_id = 2
        expect(@product).to be_valid
      end
      it "priceが300〜9999999であれば登録できる" do 
        @product.price = Faker::Number.between(from: 300, to: 9999999)
        expect(@product).to be_valid
      end
      it "priceが半角数字であれば登録できる" do
        @product.price = 9999
        expect(@product).to be_valid
      end
    end

    context "新規商品を出品できないとき" do
      it "imageが空では出品できない" do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include "Image can't be blank"
      end
      it "nameが空では出品できない" do
        @product.name = ""
        @product.valid?
        expect(@product.errors.full_messages).to include "Name can't be blank"
      end
      it "introductionが空では出品できない" do
        @product.introduction = ""
        @product.valid?
        expect(@product.errors.full_messages).to include "Introduction can't be blank"
      end
      it "category_idが1では出品できない" do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Category can't be blank"
      end
      it "charge_idが1では出品できない" do
        @product.charge_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Charge can't be blank"
      end
      it "status_idが1では出品できない" do
        @product.status_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Status can't be blank"
      end
      it "charge_idが1では出品できない" do
        @product.charge_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Charge can't be blank"
      end
      it "area_idが1では出品できない" do
        @product.area_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Area can't be blank"
      end
      it "scheduled_day_idが1では出品できない" do
        @product.scheduled_day_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Scheduled day can't be blank"
      end
      it "priceが空では出品できない" do
        @product.price = ""
        @product.valid?
        expect(@product.errors.full_messages).to include "Price can't be blank"
      end
      it "priceが300未満では出品できない" do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include "Price is out of setting range"
      end
      it "priceが999999999以上では出品できない" do
        @product.price = 10000000
        @product.valid?
        expect(@product.errors.full_messages).to include "Price is out of setting range"
      end
      it "priceが全角では出品できない" do
        @product.price = "１０００"
        @product.valid?
        expect(@product.errors.full_messages).to include "Price is invalid. Input half-width characters"
      end
    end
  end
end
