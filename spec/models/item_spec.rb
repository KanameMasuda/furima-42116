require 'rails_helper'

RSpec.describe Item, type: :model do
  # 正常系のテスト
  context '正常系: 新規登録できる場合' do
    before do
      @item = FactoryBot.build(:item)  # FactoryBotでItemを作成
    end

    it '全ての項目が正しく入力されていれば登録できる' do
      expect(@item).to be_valid
    end
  end

  # 異常系のテスト
  context '異常系: 登録できない場合' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '必須項目が空の場合' do
      it 'nameが空だと無効であること' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'descriptionが空だと無効であること' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'priceが空だと無効であること' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'category_idが未選択だと無効であること' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'condition_idが未選択だと無効であること' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it 'shipping_fee_idが未選択だと無効であること' do
        @item.shipping_fee_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
      end

      it 'prefecture_idが未選択だと無効であること' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'shipping_days_idが未選択だと無効であること' do
        @item.shipping_days_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping days can't be blank")
      end

      it 'imageが添付されていない場合、無効であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
    end

    context '価格が不正な場合' do
      it '価格が300未満だと無効であること' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be a number between 300 and 9,999,999")
      end

      it '価格が9,999,999を超えると無効であること' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be a number between 300 and 9,999,999")
      end
    end

    context '選択肢が無効な場合' do
      it 'category_idが無効な場合、無効であること' do
        @item.category_id = 1  # 無効なID
        @item.valid?
        expect(@item.errors.full_messages).to include("Category を選択してください")
      end

      it 'condition_idが無効な場合、無効であること' do
        @item.condition_id = 1  # 無効なID
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition を選択してください")
      end

      it 'shipping_fee_idが無効な場合、無効であること' do
        @item.shipping_fee_id = 1  # 無効なID
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee を選択してください")
      end

      it 'prefecture_idが無効な場合、無効であること' do
        @item.prefecture_id = 1  # 無効なID
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture を選択してください")
      end

      it 'shipping_days_idが無効な場合、無効であること' do
        @item.shipping_days_id = 1  # 無効なID
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping days を選択してください")
      end
    end
  end

    # 価格のバリデーションに関するテスト
  describe '価格のバリデーション' do
    before do
      @item = FactoryBot.build(:item, price: 1000)
    end

    context '価格が半角数値のみである場合' do
      it '価格が半角数値であれば保存できること' do
        @item.price = 1000 # 半角数値
        expect(@item).to be_valid
      end
    end

    context '価格が全角文字の場合' do
      it '全角文字は無効であること' do
        @item.price = '１０００' # 全角数値
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be a number between 300 and 9,999,999')
      end
    end

    context '価格が文字列の場合' do
      it '文字列は無効であること' do
        @item.price = 'abc' # 文字列
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be a number between 300 and 9,999,999')
      end
    end

    context '価格が空の場合' do
      it '価格が空であれば無効であること' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
    end
  end
end