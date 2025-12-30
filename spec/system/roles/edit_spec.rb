# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Role#edit' do
  context 'when visit Role Edit' do
    let(:role) { create(:role) }

    before { visit edit_role_path(id: role.id) }

    it { expect(page).to have_current_path(edit_role_path(role)) }
    it { expect(page).to have_content('Editar Vaga') }
    it { expect(page).to have_field('Nome', with: role.name) }
    it { expect(page).to have_field('Descrição', with: role.description) }
    it { expect(page).to have_select('Status', selected: role.status_humanize) }
  end
end
