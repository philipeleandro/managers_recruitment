# frozen_string_literal: true

module RolesHelper
  def link_cancel_form(page_load, role_id)
    base = 'rounded-lg w-full border border-slate-200 ' \
           'px-6 py-2 text-sm font-medium text-slate-900 ' \
           'hover:bg-slate-50 flex justify-center'

    if page_load
      return link_to 'Cancelar',
        role_id.nil? ? root_path : role_path(id: role_id),
        class: base,
        data: { turbo_frame: '_top' }
    end

    link_to 'Cancelar',
      roles_path,
      class: base,
      data: {
        turbo_frame: 'role_management',
        action: 'click->roles--roles-form#hideForm'
      }
  end

  def formatted_cnpj(cnpj)
    return cnpj unless ::Validator::Documents.valid_cnpj?(cnpj)

    cnpj_instance = CNPJ.new(cnpj)

    cnpj_instance.formatted
  end
end
