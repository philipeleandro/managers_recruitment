# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Candidates#edit' do
  context 'when visit Candidates Edit' do
    let(:candidate) { create(:candidate) }

    before { visit edit_candidate_path(id: candidate.id) }

    it { expect(page).to have_current_path(edit_candidate_path(candidate)) }
    it { expect(page).to have_content('Editar Candidato') }
    it { expect(page).to have_field('Nome', with: candidate.name) }
    it { expect(page).to have_field('Telefone', with: candidate.phone_number) }
    it { expect(page).to have_field('CPF', with: candidate.cpf) }
    it { expect(page).to have_field('E-mail', with: candidate.email) }
    it { expect(page).to have_select('Status', selected: candidate.status_humanize) }
    it { expect(page).to have_content(candidate.resume.name) }
  end
end
