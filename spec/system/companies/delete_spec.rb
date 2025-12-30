# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Company#delete', js: true do
  let(:company) { create(:company) }

  before do
    company
    visit companies_path
  end

  context 'when successfully' do
    it 'deletes a company' do
      accept_confirm do
        click_link 'delete-company-button'
      end

      expect(page).to have_current_path(companies_path)
      expect(page).to have_content('Empresa excluída com sucesso')
      expect(Company.count).to eq(0)
    end
  end
end
