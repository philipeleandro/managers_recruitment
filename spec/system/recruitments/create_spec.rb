# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recruitment#Create', js: true do
  let(:company) { create(:company) }

  context 'when successfully' do
    before do
      visit company_path(id: company.id)
      click_link 'Criar Processo Seletivo'
    end

    it 'creates a new recruitment' do
      fill_in 'Descrição', with: 'Processo Seletivo para Desenvolvedor'
      fill_in 'Data de início', with: '2023-01-01'
      fill_in 'Data de término', with: '2023-01-31'
      fill_in 'Valor', with: '5000'

      click_button 'Criar Recrutamento'

      expect(page).to have_current_path(company_path(id: company.id))
      expect(Recruitment.count).to eq(1)
    end
  end

  context 'when fails' do
    before do
      visit company_path(id: company.id)
      click_link 'Criar Processo Seletivo'
    end

    it 'shows errors when data is invalid' do
      click_button 'Criar Recrutamento'

      expect(page).to have_content('Verifique os erros abaixo')
      expect(Recruitment.count).to eq(0)
    end
  end
end
