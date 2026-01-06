# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    sequence(:name) { |n| "Role #{n}" }
    description { 'MyText' }
    status { :active }
    company
  end
end
