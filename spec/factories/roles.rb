# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name { 'MyString' }
    description { 'MyText' }
    status { :active }
    company
  end
end
