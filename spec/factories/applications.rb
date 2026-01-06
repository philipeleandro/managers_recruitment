# frozen_string_literal: true

FactoryBot.define do
  factory :application do
    candidate
    recruitment_role
    status { 'in_process' }
  end
end
