FactoryBot.define do
  factory :role do
    name { "MyString" }
    description { "MyText" }
    status { "MyString" }
    association :company
  end
end
