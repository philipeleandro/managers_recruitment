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

  context 'when has recruitment' do
    let(:company) { create(:company) }
    let(:recruitment) { create(:recruitment, company: company) }
    let(:recruitment_role) { create(:recruitment_role, recruitment: recruitment) }
    let(:parsed_value) { number_with_precision(recruitment.value.round(2), precision: 2) }

    before do
      recruitment_role
      visit company_path(company)
    end

    it { expect(page).to have_content(recruitment.status_humanize) }
    it { expect(page).to have_content(parsed_value) }
    it { expect(page).to have_content(recruitment.opening_date.strftime('%d/%m/%Y')) }
    it { expect(page).to have_content(recruitment.finish_date.strftime('%d/%m/%Y')) }
  end

  context 'when has no recruitment' do
    let(:company) { create(:company) }

    before { visit company_path(company) }

    it { expect(page).to have_content('Nenhum processo seletivo encontrado') }
  end
end
