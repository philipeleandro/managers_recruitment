# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies#Show' do
  context 'when visit Companies Show' do
    let(:company) { create(:company) }
    let(:phone) { company.phone_number }
    let(:formatted_phone) { Phonelib.parse(phone).national }
    let(:cnpj) { company.cnpj }
    let(:formatted_cnpj) { CNPJ.new(cnpj).formatted }

    before { visit company_path(company) }

    it { expect(page).to have_current_path(company_path(company)) }
    it { expect(page).to have_content('Detalhes e informações da empresa') }
    it { expect(page).to have_content(company.name) }
    it { expect(page).to have_content(formatted_phone) }
    it { expect(page).to have_content(formatted_cnpj) }
    it { expect(page).to have_content(company.responsible_name) }
    it { expect(page).to have_content(company.email) }
    it { expect(page).to have_content(company.status_humanize) }
  end
end
