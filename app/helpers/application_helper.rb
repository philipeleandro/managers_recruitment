# frozen_string_literal: true

module ApplicationHelper
  def flash_button_hover(key)
    key.to_sym == :alert ? "hover:bg-red-200" : "hover:bg-green-200"
  end

  def flash_colors(key)
    key.to_sym == :alert ?
    "bg-red-50 text-red-800 border-red-200" :
    "bg-green-50 text-green-800 border-green-200"
  end
end
