module CandidatesHelper
  def link_classes
    lambda { |is_active| filter_button_classes(is_active) }
  end

  def data_form(page_load)
    return { turbo_frame: '_top'} if page_load

    { action: 'turbo:submit-end->candidates-form#onPostSuccess' }
  end

  def status_colors
    {
      new: 'bg-yellow-100 text-yellow-700',
      active: 'bg-green-100 text-green-700',
      inactive: 'bg-red-100 text-red-700'
    }.with_indifferent_access
  end

  def link_cancel_form(page_load)
    base = 'rounded-lg w-full border border-slate-200 ' \
           'px-6 py-2 text-sm font-medium text-slate-900 ' \
           'hover:bg-slate-50 flex justify-center'

    return link_to 'Cancelar',
      request.referer || root_path,
      class: base,
      data: { turbo_frame: '_top' } if page_load

    link_to 'Cancelar',
            candidates_path,
            class: base,
            data: {
              turbo_frame: 'candidate_management',
              action: 'click->candidates-form#hideForm'
            }
  end

  def resume_present?(candidate)
    return false if candidate.blank?

    if @candidate.try(:resume).try(:attached?) && @candidate.try(:resume).try(:persisted?)
      link_to @candidate.resume.filename,
        rails_blob_path(@candidate.resume),
        target: '_blank',
        class: 'text-sm text-blue-600 hover:text-blue-700'
    else
      tag.span '-', class: 'text-sm text-slate-400'
    end
  end

  private

  def filter_button_classes(is_active)
    base = 'inline-flex rounded-lg px-4 py-2 ' \
           'text-sm font-medium cursor-pointer'

    return "#{base} bg-blue-600 text-white hover:bg-blue-700" if is_active

    "#{base} text-slate-600 hover:bg-slate-100"
  end
end
