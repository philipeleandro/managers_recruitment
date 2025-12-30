FactoryBot.define do
  factory :recruitment do
    description { "MyString" }
    status { :new }
    opening_date { "2025-12-30" }
    finish_date { "2025-12-30" }
    value { "9.99" }
    association :company
  end
end
