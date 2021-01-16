require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user1 = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user_id: @user1.id)
    @user2 = FactoryBot.create(:user)
    @order = FactoryBot.build(:order_address, user_id: @user2.id, item_id: @item.id)
    sleep(1)
  end

describe "商品の購入" do
  context "商品を購入できる場合" do
    it "必要な情報を適切に入力すると商品を購入できる" do
      expect(@order).to be_valid
    end

    it "building_nameが未入力でも商品を購入できる" do
      @order.building_name = ""
      expect(@order).to be_valid
    end
  end

  context "商品を購入出来ない場合" do
    it "tokenが空では購入できない" do
      @order.token = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("Token can't be blank")
    end

    it "user_idが空では購入できない" do
      @order.user_id = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("User can't be blank")
    end

    it "item_idが空では購入できない" do
      @order.item_id = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("Item can't be blank")
    end

    it "postal_codeが空では購入できない" do
      @order.postal_code = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("Postal code can't be blank")
    end
    
    it "postal_codeにハイフンがなければ購入できない" do
      @order.postal_code = "1234567"
      @order.valid?
      expect(@order.errors.full_messages).to include("Postal code Postal code Input correctly")
    end

    it "postal_codeは数字のみでないと購入できない" do
      @order.postal_code = "1234567a"
      @order.valid?
      expect(@order.errors.full_messages).to include("Postal code Postal code Input correctly")
    end

    it "prefecture_idが未入力では購入できない" do
      @order.prefecture_id = 1
      @order.valid?
      expect(@order.errors.full_messages).to include("Prefecture Prefecture Select")
    end

    it "cityが空では購入できない" do
      @order.city = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("City can't be blank")
    end

    it "addressesが空では購入できない" do
      @order.addresses = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("Addresses can't be blank")
    end

    it "phone_numberが空では購入できない" do
      @order.phone_number = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("Phone number can't be blank")
    end

    it "phone_numberが12桁以上なら購入できない" do
      @order.phone_number = "090123456789"
      @order.valid?
      expect(@order.errors.full_messages).to include("Phone number Phone number Input correctly")
    end
  end
end
end




