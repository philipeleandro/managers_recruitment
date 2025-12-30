# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Roles#update' do
  let(:role) { create(:role) }

  before { visit edit_role_path(id: role.id) }

  context 'when successfully' do
    it 'updates a role' do
      fill_in 'Nome', with: 'Fake'
      click_button 'Atualizar Vaga'

      expect(page).to have_current_path(roles_path)
      expect(page).to have_content('Fake')
      expect(page).to have_content('Vaga atualizada com sucesso')
    end
  end

  context 'when fails' do
    it 'updates a role' do
      fill_in 'Nome', with: ''
      click_button 'Atualizar Vaga'

      expect(page).to have_current_path(role_path(id: role.id))
      expect(page).to have_content('Verifique os erros abaixo')
      expect(page).to have_content('Nome não pode ficar em branco')
    end
  end
end
