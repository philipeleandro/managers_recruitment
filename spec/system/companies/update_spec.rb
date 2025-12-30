# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies#update' do
  let(:company) { create(:company) }

  before { visit edit_company_path(id: company.id) }

  context 'when successfully' do
    it 'updates a company' do
      fill_in 'Nome', with: 'João Silva'
      click_button 'Atualizar Empresa'

      expect(page).to have_current_path(companies_path)
      expect(page).to have_content('João Silva')
      expect(page).to have_content('Empresa atualizada com sucesso')
    end
  end

  context 'when fails' do
    let(:old_cnpj) { company.cnpj }

    it 'updates a company' do
      fill_in 'CNPJ', with: 'fake_cnpj'
      click_button 'Atualizar Empresa'

      expect(page).to have_current_path(company_path(id: company.id))
      expect(page).to have_content('Verifique os erros abaixo')
      expect(page).to have_content('CNPJ não é válido')
    end
  end
end
