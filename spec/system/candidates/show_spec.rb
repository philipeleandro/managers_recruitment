# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Candidates#Show' do
  context 'when visit Candidates Show' do
    let(:candidate) { create(:candidate) }
    let(:phone) { candidate.phone_number }
    let(:formatted_phone) { Phonelib.parse(phone).national }
    let(:cpf) { candidate.cpf }
    let(:formatted_cpf) { CPF.new(cpf).formatted }

    before { visit candidate_path(candidate) }

    it { expect(page).to have_current_path(candidate_path(candidate)) }
    it { expect(page).to have_content('Detalhes e informações do candidato') }
    it { expect(page).to have_content(candidate.name) }
    it { expect(page).to have_content(formatted_phone) }
    it { expect(page).to have_content(formatted_cpf) }
    it { expect(page).to have_content(candidate.email) }
    it { expect(page).to have_content(candidate.status_humanize) }
    it { expect(page).to have_content(candidate.resume.filename) }
  end
end
