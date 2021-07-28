FactoryBot.define do
  factory :purchase_history_address do
    token { "tok_abcdefghijk00000000000000000" }
    postcode { "123-4567" }
    area_id { 3 }
    city { "港区" }
    address { "青山1-1" }
    building_name { "青山ハイツ" }
    phone_num { "09012345678" }
  end
end
