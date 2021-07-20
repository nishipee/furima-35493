FactoryBot.define do
  factory :product do
    name               { "testtesttest" }
    introduction       { "testtesttesttesttesttesttest" }
    category_id        { 3 }
    status_id          { 3 }
    charge_id          { 3 }
    area_id            { 3 }
    scheduled_day_id   { 3 }
    price              { 5000 }
    association :user

    after(:build) do |product|
      product.image.attach(io: File.open("public/images/資格.jpg"), filename: "資格.jpg")
    end
  end
end