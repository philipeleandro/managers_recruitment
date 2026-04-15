# frozen_string_literal: true

module RolesHelper
  def description_field(form)
    tag.div(class: 'col-span-1') do
      concat form.label(:description, class: 'block text-sm text-slate-900 mb-2')
      concat form.text_area(
        :description,
        rows: 1,
        class: %w[
          block w-full rounded-lg border border-slate-300 px-4 py-2.5 text-sm text-slate-900
          placeholder-slate-500 focus:border-blue-500 focus:ring-blue-500 focus:outline-none resize-y
        ].join(' '),
        placeholder: t('roles.form.placeholder.description')
      )
    end
  end

  def cancel_link(page_load, role_id)
    base = 'rounded-lg w-full border border-slate-200 ' \
           'px-6 py-2 text-sm font-medium text-slate-900 ' \
           'hover:bg-slate-50 flex justify-center'

    if page_load
      return link_to 'Cancelar',
        role_id.nil? ? home_path : role_path(id: role_id),
        class: base,
        data: { turbo_frame: '_top' }
    end

    link_to 'Cancelar',
      roles_path,
      class: base,
      data: {
        turbo_frame: 'role_management',
        action: 'click->recruitments--recruitments-form#hideRoleForm'
      }
  end
end
