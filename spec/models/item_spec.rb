require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
  end

  describe "商品の出品" do
    context "商品が出品出来るとき" do
      it "必要な情報を適切に入力すると、商品の出品ができる" do
        expect(@item).to be_valid
      end
    end

    context "商品が出品出来ないとき" do
      it "商品画像がないと出品出来ない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it "商品名がないと出品出来ない" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it "商品の説明がないと出品できない" do
        @item.info = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end

      it "カテゴリーの情報がないと出品できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end

      it "商品の状態の情報がないと出品出来ない" do
        @item.sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status must be other than 1")
      end

      it "配送料の負担の情報がないと出品出来ない" do
        @item.shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee status must be other than 1")
      end

      it "発送元の地域の情報がないと出品出来ない" do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it "発送までの日数の情報がないと出品出来ない" do
        @item.scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery must be other than 1")
      end

      it "価格の情報がないと出品出来ない" do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it "価格の範囲が300未満では出品出来ない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end

      it "価格の範囲が10000000以上では出品出来ない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end

      it "価格は全角数字では登録出来ない" do
        @item.price = "３００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end

      it "価格は半角文字では登録出来ない" do
        @item.price = "sanbyakuen"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end

      it "価格は全角文字では登録出来ない" do
        @item.price = "三百円"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end  
    end
  end
end




