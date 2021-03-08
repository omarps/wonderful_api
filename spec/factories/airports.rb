FactoryBot.define do
  factory :airport do
    original_id { 1 }
    name { "MyString" }
    city { "MyString" }
    country { "MyString" }
    iata_faa { "MyString" }
    icao { "MyString" }
    location { "" }
    timezone { "MyString" }
  end
end
