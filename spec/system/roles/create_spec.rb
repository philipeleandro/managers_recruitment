# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Role#Create' do
  let(:company) { create(:company) }

  context 'when successfully' do
    before do
      company
      visit new_role_path
    end

    it 'creates a new role' do
      fill_in 'Nome', with: 'João Silva'
      fill_in 'Descrição', with: 'João Silva Ltda'
      select company.name, from: 'Empresa'

      click_button 'Criar Vaga'

      expect(page).to have_current_path(roles_path)
      expect(Role.count).to eq(1)
    end
  end

  context 'when fails' do
    before do
      visit new_role_path
    end

    it 'shows errors when data is invalid' do
      click_button 'Criar Vaga'

      expect(page).to have_content('Verifique os erros abaixo')
      expect(page).to have_content('Descrição não pode ficar em branco')
      expect(Company.count).to eq(0)
    end
  end
end
