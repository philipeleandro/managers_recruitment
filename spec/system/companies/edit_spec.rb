# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Company#edit' do
  context 'when visit Company Edit' do
    let(:company) { create(:company) }

    before { visit edit_company_path(id: company.id) }

    it { expect(page).to have_current_path(edit_company_path(company)) }
    it { expect(page).to have_content('Editar Empresa') }
    it { expect(page).to have_field('Nome', with: company.name) }
    it { expect(page).to have_field('Telefone', with: company.phone_number) }
    it { expect(page).to have_field('CNPJ', with: company.cnpj) }
    it { expect(page).to have_field('Nome do responsável', with: company.responsible_name) }
    it { expect(page).to have_field('E-mail', with: company.email) }
    it { expect(page).to have_select('Status', selected: company.status_humanize) }
  end
end
