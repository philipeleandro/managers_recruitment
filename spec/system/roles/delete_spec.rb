# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Role#delete', js: true do
  let(:role) { create(:role) }

  before do
    visit company_path(id: role.company.id)
    click_link 'Criar vaga'
  end

  context 'when successfully' do
    it 'deletes a role' do
      accept_confirm do
        click_link 'delete-role-button'
      end

      expect(page).to have_current_path(company_path(id: role.company.id))
      expect(page).to have_content('Vaga excluída com sucesso')
      expect(Role.count).to eq(0)
    end
  end
end
