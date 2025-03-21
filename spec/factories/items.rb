FactoryBot.define do
  factory :item do
    name { 'MyString' }
    description { 'MyText' }
    price { 300 }
    category_id { 2 }  # デフォルトで適切な値を設定
    condition_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    shipping_days_id { 2 }
    user { association :user }  # 関連モデルとしてuserを指定

    # 画像が必要な場合は以下を追加
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test_image.png'), 'image/png') }
  end
end
