FactoryBot.define do
  factory :user do
    nickname              { Faker::Name }
    email                 { Faker::Internet.free_email }
    password              { "abcd12" }
    password_confirmation { password }
    last_name             { "山田" }
    first_name            { "太郎" }
    last_name_kana        { "ヤマダ" }
    first_name_kana       { "タロウ" }
    birthday              { "1998-01-01" }
  end
end
