FactoryBot.define do
  factory :order_address do
    association :user
    association :item

    postal_code { '123-4567' }
    prefecture_id { 13 }
    city { 'Shibuya' }
    addresses { '1-2-3' }
    building { 'Shibuya Tower' }
    phone_number { '08012345678' }
    token { 'abcdef12345' }
  end
end
