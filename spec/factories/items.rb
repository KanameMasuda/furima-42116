FactoryBot.define do
  factory :item do
    name { 'MyString' }
    description { 'MyText' }
    price { 1 }
    category_id { 1 }
    condition_id { 1 }
    shipping_fee_id { 1 }
    prefecture_id { 1 }
    shipping_days_id { 1 }
    user { nil }
  end
end
