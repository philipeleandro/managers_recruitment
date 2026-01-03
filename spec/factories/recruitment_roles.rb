# frozen_string_literal: true

FactoryBot.define do
  factory :recruitment_role do
    role
    recruitment
    quantity { 1 }
  end
end
