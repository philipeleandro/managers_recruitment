# frozen_string_literal: true

class Application::Status < EnumerateIt::Base
  associate_values(
    :in_process,
    :rejected,
    :approved
  )
end
