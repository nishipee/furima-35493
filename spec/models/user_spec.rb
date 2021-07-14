require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end


  describe "ユーザー新規登録" do
    context "新規登録できるとき" do
      it "nickname、email、password、password_confirmation、last_name、first_name、last_name_kana、first_name_kana、birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "passwordとpassword_confirmationが英数字6文字以上であれば登録できる" do
        @user.password = "aaa000"
        @user.password_confirmation = "aaa000"
        expect(@user).to be_valid
      end
      it "last_nameとfirst_nameが全角かなであれば登録できる" do
        @user.last_name = "やまだ"
        @user.first_name = "たろう"
        expect(@user).to be_valid
      end
      it "last_nameとfirst_nameが全角カナであれば登録できる" do
        @user.last_name = "ヤマダ"
        @user.first_name = "タロウ"
        expect(@user).to be_valid
      end
      it "last_nameとfirst_nameが全角漢字であれば登録できる" do
        expect(@user).to be_valid
      end
      it "last_name_kanaとfirst_name_kanaが全角カナであれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context "新規登録できないとき" do
      it "nicknameが空では登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it "password_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it "last_nameが空では登録できない" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it "first_nameが空では登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it "last_name_kanaが空では登録できない" do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank"
      end
      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include  "First name kana can't be blank"
      end
      it "birthdayが空では登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
      it "emailが重複していると登録できない" do
        another_user = FactoryBot.build(:user)
        another_user.save
        @user.email = another_user.email
        @user.valid?
        expect(@user.errors.full_messages).to include "Email has already been taken"
      end
      it "passwordが5文字以下では登録できない" do
        @user.password = "abc12"
        @user.password_confirmation = "abc12"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end
      it "passwordが英字だけでは登録できない" do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invaild. Include both letters and numbers"
      end
      it "passwordが数字だけでは登録できない" do
        @user.password = "000000"
        @user.password_confirmation = "000000"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invaild. Include both letters and numbers"
      end
      it "passwordが全角では登録できない" do
        @user.password = "xyz１２３"
        @user.password_confirmation = "xyz１２３"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invaild. Include both letters and numbers"
      end
      it "last_nameが英字では登録できない" do
        @user.last_name = "yamada"
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name is invalid. Input full-width characters"
      end
      it "first_nameが英字では登録できない" do
        @user.first_name = "tarou"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name is invalid. Input full-width characters"
      end
      it "last_name_kanaが全角かなでは登録できない" do
        @user.last_name_kana = "やまだ"
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana is invalid. Input full-width katakana characters"
      end
      it "last_name_kanaが全角漢字では登録できない" do
        @user.last_name_kana = "山田"
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana is invalid. Input full-width katakana characters"
      end
      it "last_name_kanaが英字では登録できない" do
        @user.last_name_kana = "yamada"
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana is invalid. Input full-width katakana characters"
      end
      it "first_name_kanaがで全角かなでは登録できない" do
        @user.first_name_kana = "たろう"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana is invalid. Input full-width katakana characters"
      end
      it "first_name_kanaが全角漢字では登録できない" do
        @user.first_name_kana = "太郎"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana is invalid. Input full-width katakana characters"
      end
      it "first_name_kanaが英字では登録できない" do
        @user.first_name_kana = "tarou"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana is invalid. Input full-width katakana characters"
      end
    end
  end
end

