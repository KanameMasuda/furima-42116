FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    nickname              { Faker::Name.name }
    last_name             { Faker::Name.last_name }
    first_name            { Faker::Name.first_name }
    last_name_kana        { 'ヤマダ' }
    first_name_kana       { 'タロウ' }
    birth_date            { '2000-01-01' }
  end
end
