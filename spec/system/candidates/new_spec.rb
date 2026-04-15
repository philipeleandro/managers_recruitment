# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Candidates#New' do
  context 'when visit Candidates New' do
    before do
      sign_in_as_admin
      visit new_candidate_path
    end

    it { expect(page).to have_current_path(new_candidate_path) }
    it { expect(page).to have_content('Adicionar Novo Candidato') }
    it { expect(page).to have_field('Nome') }
    it { expect(page).to have_field('Telefone') }
    it { expect(page).to have_field('CPF') }
    it { expect(page).to have_field('E-mail') }
    it { expect(page).to have_field('Status') }
    it { expect(page).to have_field('Currículo') }
  end
end
