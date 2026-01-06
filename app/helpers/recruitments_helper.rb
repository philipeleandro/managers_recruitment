# frozen_string_literal: true


module RecruitmentsHelper
  def create_or_copy_link_button(recruitment_role)
    recruitment_role.open_to_applications? ? copy_button(recruitment_role) : ''
  end

  private

  def copy_button(recruitment_role)
    button_tag "Copiar o link",
      type: 'button',
      class: "flex rounded-lg bg-white border border-slate-200 px-4 py-2 text-sm font-medium text-slate-900 text-center hover:bg-slate-50",
      data: {
        controller: "clipboard",
        clipboard_text_value: apply_url(token: recruitment_role.token),
        action: "click->clipboard#copy"
      }
  end
end
