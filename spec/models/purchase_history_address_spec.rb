require 'rails_helper'

RSpec.describe PurchaseHistoryAddress, type: :model do
  describe "商品購入機能" do
    before do
      user = FactoryBot.create(:user)
      product = FactoryBot.create(:product)
      @purchase_history_address = FactoryBot.build(:purchase_history_address, user_id: user.id, product_id: product.id)
      sleep(1)
    end

    context "内容に問題がない場合" do
      it "tokenがあり全ての値が正しく入力されていれば購入できる" do
        expect(@purchase_history_address).to be_valid
      end
      it "building_nameが空でも購入できる" do
        @purchase_history_address.building_name = ""
        expect(@purchase_history_address).to be_valid
      end
    end

    context "内容に問題がある場合" do
      it "tokenが空では購入できない" do
        @purchase_history_address.token = ""
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Token can't be blank")
      end
      it "postcodeが空では購入できない" do
        @purchase_history_address.postcode = ""
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Postcode can't be blank")
      end
      it "area_idが1では購入できない" do
        @purchase_history_address.area_id = 1
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Area can't be blank")
      end
      it "cityが空では購入できない" do
        @purchase_history_address.city = ""
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("City can't be blank")
      end
      it "addressが空では購入できない" do
        @purchase_history_address.address = ""
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Address can't be blank")
      end
      it "phone_numが空では購入できない" do
        @purchase_history_address.phone_num = ""
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Phone num can't be blank")
      end
      it "郵便番号が全角数字では購入できない" do
        @purchase_history_address.postcode = "１２３ー４５６７"
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it "郵便番号にハイフンが含まれていなければ購入できない" do
        @purchase_history_address.postcode = "1234567"
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it "電話番号が全角数字では購入できない" do
        @purchase_history_address.phone_num = "０９０１２３４５６７８"
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Phone num is invalid. Input only number")
      end
      it "電話番号が12桁以上では購入できない" do
        @purchase_history_address.phone_num = "090123456789"
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Phone num is too long (maximum is 11 characters)")
      end
      it "電話番号が英数混合では交遊できない" do
        @purchase_history_address.phone_num = "090abcd5678"
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Phone num is invalid. Input only number")
      end
      it "userが紐づいていないと購入できない" do
        @purchase_history_address.user_id = nil
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("User can't be blank")
      end
      it "productが紐づいていないと購入できない" do
        @purchase_history_address.product_id = nil
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Product can't be blank")
      end
    end
  end
end
