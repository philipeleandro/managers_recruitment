# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recruitment#delete', js: true do
  let(:company) { create(:company) }
  let(:recruitment) { create(:recruitment, company: company) }
  let(:recruitment_role) { create(:recruitment_role, recruitment: recruitment) }

  context 'when successfully' do
    before do
      recruitment_role

      visit company_path(id: company.id)
    end

    it 'deletes a recruitment' do
      accept_confirm do
        click_link 'delete-recruitment-button'
      end

      expect(page).to have_current_path(company_path(company))
      expect(page).to have_content('Processo Seletivo excluído com sucesso')
      expect(Recruitment.count).to eq(0)
    end
  end
end
