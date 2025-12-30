# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Company#New' do
  context 'when visit Company New' do
    before { visit new_company_path }

    it { expect(page).to have_current_path(new_company_path) }
    it { expect(page).to have_content('Adicionar Nova Empresa') }
    it { expect(page).to have_field('Nome') }
    it { expect(page).to have_field('Telefone') }
    it { expect(page).to have_field('CNPJ') }
    it { expect(page).to have_field('E-mail') }
    it { expect(page).to have_field('Status') }
    it { expect(page).to have_field('Nome do responsável') }
  end
end
