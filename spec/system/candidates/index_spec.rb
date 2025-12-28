# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Candidates#Index' do
  context 'when visit Candidates Index' do
    context 'when there is candidates' do
      let(:candidate) { create(:candidate) }

      before do
        candidate
        visit candidates_path
      end

      it { expect(page).to have_current_path(candidates_path) }
      it { expect(page).to have_content('Lista de Candidatos') }
      it { expect(page).to have_content('Nome') }
      it { expect(page).to have_content('Telefone') }
      it { expect(page).to have_content('CPF') }
      it { expect(page).to have_content('E-mail') }
      it { expect(page).to have_content('Status') }
      it { expect(page).to have_content('Currículo') }
      it { expect(page).to have_content('Ações') }

      context 'with filter', js: true do
        before do
          fill_in 'query', with: candidate.name
          find('input[name="query"]').send_keys(:enter)
        end

        it { expect(page).to have_content('Lista de Candidatos') }
        it { expect(page).to have_content(candidate.name) }
      end
    end

    context 'when there is no candidates' do
      before { visit candidates_path }

      it { expect(page).to have_current_path(candidates_path) }
      it { expect(page).to have_content('Lista de Candidatos') }
      it { expect(page).to have_content('Nenhum candidato encontrado') }
    end
  end
end
