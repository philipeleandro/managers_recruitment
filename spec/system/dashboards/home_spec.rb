# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboards#Home' do
  context 'when visit dashboards home' do
    before do
      sign_in_as_admin
      visit home_path
    end

    it { expect(page).to have_current_path(home_path) }
    it { expect(page).to have_content('Processos Novos') }
    it { expect(page).to have_content('Processos em Andamento') }
    it { expect(page).to have_content('Bem vindo de volta') }
  end

  context 'when click on services links' do
    context 'when click on create candidate' do
      before do
        sign_in_as_admin
        visit home_path
        click_link 'Adicionar candidato'
      end

      it { expect(page).to have_current_path(new_candidate_path) }
      it { expect(page).to have_content('Adicionar Novo Candidato') }
    end
  end
end
