# frozen_string_literal: true

class Candidate::Status < EnumerateIt::Base
  associate_values(
    :new,
    :active,
    :inactive
  )
end
