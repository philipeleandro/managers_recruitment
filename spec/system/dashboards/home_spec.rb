# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboards#Home' do
  context 'when visit dashboards home' do
    before { visit root_path }

    it { expect(page).to have_current_path(root_path) }
    it { expect(page).to have_content('Processos abertos') }
    it { expect(page).to have_content('Bem vindo de volta') }
  end

  context 'when click on services links' do
    context 'when click on create candidate' do
      before do
        visit root_path
        click_link 'Adicionar candidato'
      end

      it { expect(page).to have_current_path(new_candidate_path) }
      it { expect(page).to have_content('Adicionar Novo Candidato') }
    end
  end
end
