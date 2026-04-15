# frozen_string_literal: true

class Admin::Status < EnumerateIt::Base
  associate_values(
    :active,
    :inactive
  )
end
