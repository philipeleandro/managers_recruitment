# frozen_string_literal: true

module CandidatesHelper
  def formatted_cpf(cpf)
    return cpf unless ::Validator::Documents.valid_cpf?(cpf)

    cpf_instance = CPF.new(cpf)

    cpf_instance.formatted
  end

  def formatted_phone(phone)
    return phone unless ::Phonelib.valid_for_country?(phone, 'BR')

    ::Phonelib.parse(phone).national
  end

  def link_cancel_form(page_load, candidate_id)
    base = 'rounded-lg w-full border border-slate-200 ' \
           'px-6 py-2 text-sm font-medium text-slate-900 ' \
           'hover:bg-slate-50 flex justify-center'

    if page_load
      return link_to 'Cancelar',
        candidate_id.nil? ? root_path : candidate_path(id: candidate_id),
        class: base,
        data: { turbo_frame: '_top' }
    end

    link_to 'Cancelar',
      candidates_path,
      class: base,
      data: {
        turbo_frame: 'candidate_management',
        action: 'click->candidates--candidates-form#hideForm'
      }
  end

  def resume_present?(candidate)
    return false if candidate.blank?

    if candidate.try(:resume).try(:attached?) && candidate.try(:resume).try(:persisted?)
      link_to candidate.resume.filename,
        rails_blob_path(candidate.resume),
        target: '_blank',
        class: 'text-sm text-blue-600 hover:text-blue-700',
        rel: 'noopener'
    else
      tag.span '-', class: 'text-sm text-slate-400'
    end
  end
end
