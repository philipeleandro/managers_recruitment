# frozen_string_literal: true

FactoryBot.define do
  factory :candidate do
    sequence(:email) { |n| "user#{n}@test.com" }
    cpf { CPF.generate }
    status { :new }
    phone_number { '11999999999' }
    name { 'Joe' }

    after(:build) do |candidate|
      candidate.resume.attach(
        io: Rails.root.join('spec/fixtures/files/resume_test.pdf').open,
        filename: 'resume_test.pdf',
        content_type: 'application/pdf'
      )
    end
  end
end
