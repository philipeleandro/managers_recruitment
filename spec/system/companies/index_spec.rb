# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Company#Index' do
  context 'when visit Company Index' do
    context 'when there is Company' do
      let(:company) { create(:company) }

      before do
        company
        visit companies_path
      end

      it { expect(page).to have_current_path(companies_path) }
      it { expect(page).to have_content('Lista de Empresas') }
      it { expect(page).to have_content('Nome') }
      it { expect(page).to have_content('Telefone') }
      it { expect(page).to have_content('CNPJ') }
      it { expect(page).to have_content('E-mail') }
      it { expect(page).to have_content('Status') }
      it { expect(page).to have_content('Nome do responsável') }
      it { expect(page).to have_content('Ações') }

      context 'with filter', js: true do
        before do
          fill_in 'query', with: company.name
          find('input[name="query"]').send_keys(:enter)
        end

        it { expect(page).to have_content('Lista de Empresas') }
        it { expect(page).to have_content(company.name) }
      end
    end

    context 'when there is no companies' do
      before { visit companies_path }

      it { expect(page).to have_current_path(companies_path) }
      it { expect(page).to have_content('Lista de Empresas') }
      it { expect(page).to have_content('Nenhuma empresa encontrada') }
    end
  end
end
