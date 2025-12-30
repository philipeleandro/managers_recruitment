# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Company#Create' do
  before { visit new_company_path }

  context 'when successfully' do
    it 'creates a new company' do
      fill_in 'Nome', with: 'João Silva'
      fill_in 'Telefone', with: '11999999999'
      fill_in 'CNPJ', with: CNPJ.generate
      fill_in 'E-mail', with: 'user@test.com'
      fill_in 'Nome do responsável', with: 'Responsável'
      click_button 'Criar Empresa'

      expect(page).to have_current_path(companies_path)
      expect(Company.count).to eq(1)
    end
  end

  context 'when fails' do
    it 'shows errors when data is invalid' do
      fill_in 'Nome', with: 'João Silva'
      fill_in 'Telefone', with: '11999999999'
      fill_in 'CNPJ', with: '11111'
      fill_in 'E-mail', with: 'user@test.com'
      fill_in 'Nome do responsável', with: 'Responsável'
      click_button 'Criar Empresa'

      expect(page).to have_content('Verifique os erros abaixo')
      expect(page).to have_content('CNPJ não é válido')
      expect(Company.count).to eq(0)
    end
  end
end
