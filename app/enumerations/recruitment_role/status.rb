# frozen_string_literal: true

class RecruitmentRole::Status < EnumerateIt::Base
  associate_values(
    :new,
    :open_to_applications,
    :closed_to_applications
  )
end
