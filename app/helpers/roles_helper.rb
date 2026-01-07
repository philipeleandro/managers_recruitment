# frozen_string_literal: true

module RolesHelper
  def description_field(form)
    tag.div(class: "col-span-1") do
      concat form.label(:description, class: "block text-sm text-slate-900 mb-2")
      concat form.text_area(:description,
        rows: 1,
        class: "block w-full rounded-lg border border-slate-300 px-4 py-2.5 text-sm text-slate-900 placeholder-slate-500 focus:border-blue-500 focus:ring-blue-500 focus:outline-none resize-y",
        placeholder: t('roles.form.placeholder.description')
      )
    end
  end
end
