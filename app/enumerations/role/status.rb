# frozen_string_literal: true

class Role::Status < EnumerateIt::Base
  associate_values(
    :active,
    :inactive
  )
end
