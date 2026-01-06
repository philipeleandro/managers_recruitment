# frozen_string_literal: true

FactoryBot.define do
  factory :recruitment_role do
    role
    recruitment
    status { :open_to_applications }
    quantity { 1 }
  end
end
