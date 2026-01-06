FactoryBot.define do
  factory :application do
    candidate
    recruitment_role
    status { "open_to_applications" }
  end
end
