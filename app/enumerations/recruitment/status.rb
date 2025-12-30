# frozen_string_literal: true

class Recruitment::Status < EnumerateIt::Base
  associate_values(
    :new,
    :in_progress,
    :completed
  )
end
