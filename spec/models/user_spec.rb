require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '正常系: 新規登録できる場合' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '異常系: ユーザー登録できない場合' do
      context '必須項目が空の場合' do
        it 'nicknameが空だと無効' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end

        it 'last_nameが空だと無効' do
          @user.last_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name can't be blank")
        end

        it 'first_nameが空だと無効' do
          @user.first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank")
        end

        it 'last_name_kanaが空だと無効' do
          @user.last_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name kana can't be blank")
        end

        it 'first_name_kanaが空だと無効' do
          @user.first_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("First name kana can't be blank")
        end

        it 'emailが空だと無効' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end

        it 'passwordが空だと無効' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end
      end

      context 'フォーマットが不正な場合' do
        it 'last_nameがひらがな・カタカナ・漢字以外だと無効' do
          @user.last_name = 'tanaka123'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name はひらがな・カタカナ・漢字のみ使用できます')
        end

        it 'first_nameがひらがな・カタカナ・漢字以外だと無効' do
          @user.first_name = 'tarou123'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name はひらがな・カタカナ・漢字のみ使用できます')
        end

        it 'last_name_kanaがカタカナ以外だと無効' do
          @user.last_name_kana = 'たなか'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name kana はカタカナのみ使用できます')
        end

        it 'first_name_kanaがカタカナ以外だと無効' do
          @user.first_name_kana = 'たろう'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name kana はカタカナのみ使用できます')
        end

        it 'emailに@が含まれていないと無効' do
          @user.email = 'testmail'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end

        it 'passwordが英数字混合でないと無効 (数字のみ)' do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password は英数字を両方含める必要があります')
        end

        it 'passwordが英数字混合でないと無効 (英字のみ)' do
          @user.password = 'abcdef'
          @user.password_confirmation = 'abcdef'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password は英数字を両方含める必要があります')
        end
      end

      context 'バリデーション違反の場合' do
        it '同じメールアドレスは登録できない' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end

        it 'passwordが6文字未満だと無効' do
          @user.password = 'a1b2c'
          @user.password_confirmation = 'a1b2c'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end

        it 'passwordとpassword_confirmationが一致しないと無効' do
          @user.password = 'a1b2c3'
          @user.password_confirmation = 'a1b2c4'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
      end
    end
  end
end
