# frozen_string_literal: true

module ApplicationHelper
  include ActionView::Helpers::NumberHelper

  def sortable(column, title = nil, direction = nil)
    icon = if asc_or_desc(direction) == 'asc'
      inline_svg_tag('icons/asc_direction.svg', class: 'w-4 h-4 ml-1')
    else
      inline_svg_tag('icons/desc_direction.svg', class: 'w-4 h-4 ml-1')
    end

    link_to safe_join([title, icon]),
      request.params.merge(sort: column, direction: asc_or_desc(direction)),
      class: "flex items-center justify-center cursor-pointer hover:text-blue-600 #{if params[:sort] == column
                                                                                      'text-blue-600 font-bold'
      end}",
      data: { turbo_action: 'advance', turbo_frame: 'recruitment_list' }
  end

  def flash_button_hover(key)
    key.to_sym == :alert ? 'hover:bg-red-200' : 'hover:bg-green-200'
  end

  def flash_colors(key)
    return 'bg-red-50 text-red-800 border-red-200' if key.to_sym == :alert

    'bg-green-50 text-green-800 border-green-200'
  end

  def status_colors
    {
      new: 'bg-yellow-100 text-yellow-700',
      active: 'bg-green-100 text-green-700',
      inactive: 'bg-red-100 text-red-700',
      in_progress: 'bg-blue-100 text-blue-700',
      finished: 'bg-green-100 text-green-700',
      canceled: 'bg-red-100 text-red-700',
      in_process: 'bg-yellow-100 text-yellow-700',
      rejected: 'bg-red-100 text-red-700',
      approved: 'bg-green-100 text-green-700'
    }.with_indifferent_access
  end

  def formatted_phone(phone)
    return phone unless ::Phonelib.valid_for_country?(phone, 'BR')

    ::Phonelib.parse(phone).national
  end

  def link_classes
    ->(is_active) { filter_button_classes(is_active) }
  end

  def data_form(page_load)
    return { turbo_frame: '_top' } if page_load

    { action: "turbo:submit-end->#{controller_name}--#{controller_name}-form#onPostSuccess" }
  end

  private

  def filter_button_classes(is_active)
    base = 'inline-flex rounded-lg px-4 py-2 ' \
           'text-sm font-medium cursor-pointer'

    return "#{base} bg-blue-600 text-white hover:bg-blue-700" if is_active

    "#{base} text-slate-600 hover:bg-slate-100"
  end

  def asc_or_desc(current_direction)
    current_direction == 'asc' ? 'desc' : 'asc'
  end
end
