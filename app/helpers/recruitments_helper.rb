# frozen_string_literal: true

module RecruitmentsHelper
  def create_or_copy_link_button(recruitment_role)
    recruitment_role.open_to_applications? ? copy_button(recruitment_role) : ''
  end

  def join_roles_and_quantity(roles)
    return if roles.empty?

    roles_quantity = roles.map do |role|
      recruitment_role = role.recruitment_roles.find_by(role_id: role.id)

      "#{role.name} (#{recruitment_role.quantity})"
    end

    roles_quantity.join(', ')
  end

  private

  def copy_button(recruitment_role)
    button_tag(
      'Copiar o link',
      type: 'button',
      class: %w[
        flex rounded-lg bg-white border border-slate-200 px-4 py-2 text-sm
        font-medium text-slate-900 text-center hover:bg-slate-50
      ].join(' '),
      data: {
        controller: 'clipboard',
        clipboard_text_value: apply_url(token: recruitment_role.token),
        action: 'click->clipboard#copy'
      }
    )
  end
end
