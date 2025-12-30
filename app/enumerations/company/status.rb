# frozen_string_literal: true

class Company::Status < EnumerateIt::Base
  associate_values(
    :active,
    :inactive
  )
end
