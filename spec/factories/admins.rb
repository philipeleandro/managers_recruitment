# frozen_string_literal: true

FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "admin#{n}@test.com" }
    password { 'password123' }
    password_confirmation { password }
  end
end
