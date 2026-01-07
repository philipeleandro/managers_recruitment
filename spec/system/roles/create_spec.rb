# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Role#Create', js: true do
  let(:company) { create(:company) }

  context 'when successfully' do
    context 'when visiting company view' do
      before do
        visit company_path(id: company.id)
        click_link 'Criar cargo'
      end

      it 'creates a new role' do
        fill_in 'Nome', with: 'João Silva'
        fill_in 'Descrição', with: 'João Silva Ltda'

        click_button 'Criar Cargo'

        expect(page).to have_current_path(company_path(id: company.id))
        expect(Role.count).to eq(1)
      end
    end

    context 'when visiting role view' do
      before do
        company
        visit roles_path
        click_link 'Criar Cargo'
      end

      it 'creates a new role' do
        fill_in 'Nome', with: 'João Silva'
        select company.name, from: 'Empresa'
        fill_in 'Descrição', with: 'João Silva Ltda'

        click_button 'Criar Cargo'

        expect(page).to have_current_path(roles_path)
        expect(Role.count).to eq(1)
      end
    end
  end

  context 'when fails' do
    before do
      visit company_path(id: company.id)
      click_link 'Criar cargo'
    end

    it 'shows errors when data is invalid' do
      click_button 'Criar Cargo'

      expect(page).to have_content('Verifique os erros abaixo')
      expect(page).to have_content('Descrição não pode ficar em branco')
      expect(Role.count).to eq(0)
    end
  end
end
