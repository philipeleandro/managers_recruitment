# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recruitment#update', js: true do
  let(:company) { create(:company) }
  let(:recruitment) { create(:recruitment, company: company) }
  let(:recruitment_role) { create(:recruitment_role, recruitment: recruitment) }

  context 'when successfully' do
    before do
      recruitment_role

      visit company_path(id: company.id)
      click_link 'edit-recruitment-button'
    end

    it 'updates an existing recruitment' do
      fill_in 'Descrição', with: 'Updated description'
      fill_in 'Valor', with: 0.99
      fill_in 'Data de início', with: '2026-01-01'
      fill_in 'Data de término', with: '2026-01-31'
      select 'Novo', from: 'Status'
      click_button 'Atualizar Recrutamento'

      expect(page).to have_current_path(company_path(id: company.id))
      expect(page).to have_content('Processo Seletivo atualizado com sucesso')
    end
  end

  context 'when fails' do
    before do
      recruitment_role

      visit company_path(id: company.id)
      click_link 'edit-recruitment-button'
    end

    it 'shows errors when data is invalid' do
      fill_in 'Descrição', with: ''
      click_button 'Atualizar Recrutamento'

      expect(page).to have_content('Verifique os erros abaixo')
    end
  end
end
