# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Candidates#show' do
  let(:candidate) { create(:candidate) }

  before { visit candidate_path(candidate) }

  describe 'page content' do
    context 'when viewing candidate details' do
      let(:phone) { candidate.phone_number }
      let(:formatted_phone) { Phonelib.parse(phone).national }
      let(:cpf) { candidate.cpf }
      let(:formatted_cpf) { CPF.new(cpf).formatted }

      it { expect(page).to have_current_path(candidate_path(candidate)) }
      it { expect(page).to have_content('Detalhes e informações do candidato') }
      it { expect(page).to have_content(candidate.name) }
      it { expect(page).to have_content(formatted_phone) }
      it { expect(page).to have_content(formatted_cpf) }
      it { expect(page).to have_content(candidate.email) }
      it { expect(page).to have_content(candidate.status_humanize) }
      it { expect(page).to have_content(candidate.resume.filename) }
    end

    context 'when a candidate has no applications' do
      it 'shows a message for no applications' do
        expect(page).to have_content('Nenhuma candidatura encontrada')
      end
    end

    context 'when a candidate has applications' do
      let(:applications) { create_list(:application, 3, candidate: candidate) }
      let(:first_application) { applications.first }

      before do
        applications
        visit candidate_path(candidate)
      end

      it 'shows the list of applications' do
        expect(page).to have_css('tbody tr', count: 3)
      end

      it 'shows the application details' do
        within('tbody tr', text: first_application.recruitment_role.role.name) do
          expect(page).to have_link(
            'Acessar página',
            href: recruitment_path(first_application.recruitment_role.recruitment)
          )
          expect(page).to have_content(first_application.recruitment_role.role.name)
          expect(page).to have_content(first_application.status_humanize)
        end
      end
    end
  end
end
