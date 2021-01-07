require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context '新規登録がうまくいくとき' do
    it "nicknameとemail、passwordとpassword_confirmation、birth_date_idとlast_nameとfirst_name、last_name_kanaとfirst_name_kanaが存在すれば登録できる" do
      expect(@user).to be_valid 
    end   
  end

  context '新規登録がうまくいかないとき' do
    it "ニックネームが空だと登録できない" do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it "メールアドレスが空だと登録できない" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "重複したメールアドレスが存在すると登録できない" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it "メールアドレスに@が含まれていないと登録できない" do
      @user.email = "hogehoge"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "パスワードが空だと登録できない" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    
    it "パスワードが5文字以下では登録できない" do
      @user.password = "aaaa1"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "パスワードが半角英字だけでは登録できない" do
      @user.password = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "パスワードが半角数字だけでは登録できない" do
      @user.password = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "パスワードが全角文字だけでは登録できない" do
      @user.password = 'ああああああ'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "パスワードが全角数字だけでは登録できない" do
      @user.password = '１１１１１１'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "パスワードと確認パスワードの２回入力しないと登録できない" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "パスワードと確認パスワードが不一致では登録できない" do
      @user.password = "123456a"
      @user.password_confirmation = "123456b"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "ユーザーの名字が空では登録できない" do
      @user.last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "ユーザーの名前が空では登録できない" do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "ユーザーの名字が半角では登録出来ない" do
      @user.last_name = "aaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name 全角文字を使用してください")
    end

    it "ユーザーの名前が半角では登録出来ない" do
      @user.first_name = "aaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name 全角文字を使用してください")
    end

    it "ユーザーの名字のフリガナが空では登録できない" do
      @user.last_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it "ユーザーの名前のフリガナが空では登録できない" do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it "ユーザーの名字のフリガナがカタカナでないと登録出来ない" do
      @user.last_name_kana = "あああ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana 全角カナを使用してください")
    end

    it "ユーザーの名前のフリガナがカタカナでないと登録出来ない" do
      @user.first_name_kana = "あああ"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana 全角カナを使用してください")
    end

    it "生年月日を入力しないと登録できない" do
      @user.birth_date_id = "" 
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end
