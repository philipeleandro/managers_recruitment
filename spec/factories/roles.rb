FactoryBot.define do
  factory :role do
    name { "MyString" }
    description { "MyText" }
    status { :active }
    association :company
  end
end
