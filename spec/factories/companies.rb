# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { "Joe's Company" }
    cnpj { CNPJ.generate }
    sequence(:email) { |n| "user#{n}@test.com" }
    responsible_name { 'Company' }
    phone_number { '11999999999' }
    status { :active }
  end
end
