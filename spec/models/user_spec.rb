require 'rails_helper'

RSpec.describe User, type: :model do
  
  before do
    @user = FactoryBot.build(:user)
  end

    context 'メールアドレスが必須であること' do
      it 'メールアドレスが空の場合、無効であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
    end

    context 'メールアドレスの一意性が必要であること' do
      it '同じメールアドレスでユーザーが既に存在する場合、新しいユーザーが無効であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
    end

    context 'メールアドレスは、@を含む必要があること' do
      it 'メールアドレスに@が含まれていない場合、無効であること' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
    end

    context 'パスワードが必須であること' do
      it 'パスワードが空の場合、無効であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
    end

    context 'パスワードは6文字以上である必要があること' do
      it 'パスワードが6文字未満の場合、無効であること' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
    end

    context 'パスワードと確認用パスワードが一致すること' do
      it 'パスワードと確認用パスワードが一致しない場合、無効であること' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end