# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recruitments#show', js: true do
  let(:company) { create(:company) }
  let(:recruitment) { create(:recruitment, company: company) }
  let(:ruby_role) { create(:role, name: 'Ruby Developer', company: company) }
  let(:react_role) { create(:role, name: 'React Developer', company: company) }
  let(:value_formatted) { ActionController::Base.helpers.number_with_precision(recruitment.value.round(2), precision: 2) }

  describe 'page content' do
    context 'when a recruitment has roles and applications' do
      let(:ruby_recruitment_role) { create(:recruitment_role, recruitment: recruitment, role: ruby_role) }
      let(:applications) { create_list(:application, 2, recruitment_role: ruby_recruitment_role) }
      let(:react_recruitment_role) { create(:recruitment_role, recruitment: recruitment, role: react_role) }

      before do
        react_recruitment_role
        applications
        visit recruitment_path(recruitment)
      end

      context 'when shows recruitment details' do
        it { expect(page).to have_content(I18n.t('recruitments.show.title')) }
        it { expect(page).to have_content("R$ #{value_formatted}") }
        it { expect(page).to have_content(recruitment.opening_date.strftime('%d/%m/%Y')) }
        it { expect(page).to have_content(recruitment.finish_date.strftime('%d/%m/%Y')) }
        it { expect(page).to have_content(recruitment.company.name) }
        it { expect(page).to have_content(recruitment.description) }
      end

      it 'shows associated role names' do
        expect(page).to have_content('Ruby Developer')
        expect(page).to have_content('React Developer')
      end

      it 'shows total application count' do
        expect(page).to have_content('2')
      end

      it 'lists applications for the default role' do
        expect(page).to have_css('tbody tr', count: 2)
      end
    end
  end

  describe 'page functionality' do
    context 'when filtering roles' do
      let(:ruby_recruitment_role) { create(:recruitment_role, recruitment: recruitment, role: ruby_role) }
      let(:react_recruitment_role) { create(:recruitment_role, recruitment: recruitment, role: react_role) }

      before do
        ruby_recruitment_role
        react_recruitment_role
        visit recruitment_path(recruitment)
      end

      it 'shows the first role by default' do
        within('div[data-recruitments--recruitments-target="rolesListWrapper"]') do
          expect(page).to have_css('h2', text: 'React Developer')
          expect(page).not_to have_css('h2', text: 'Ruby Developer')
        end
      end

      it 'switches to another role when filter is clicked' do
        click_button 'Ruby Developer'

        within('div[data-recruitments--recruitments-target="rolesListWrapper"]') do
          expect(page).to have_css('h2', text: 'Ruby Developer')
          expect(page).not_to have_css('h2', text: 'React Developer')
        end
      end
    end

    context 'when managing recruitment role status' do
      let(:recruitment_role_open) do
        create(:recruitment_role, recruitment: recruitment, role: ruby_role, status: :open_to_applications)
      end
      let(:recruitment_role_closed) do
        create(:recruitment_role, recruitment: recruitment, role: react_role, status: :closed_to_applications)
      end

      before do
        recruitment_role_open
        recruitment_role_closed
        visit recruitment_path(recruitment)
      end

      it 'hides copy link button when closing applications' do
        click_button 'Ruby Developer'

        expect(page).to have_button('Copiar o link')

        find("a[title='Fechar processo para candidaturas']").click

        expect(page).not_to have_button('Copiar o link')
      end

      it 'shows copy link button when opening applications' do
        click_button 'React Developer'

        expect(page).not_to have_button('Copiar o link')

        find("a[title='Abrir processo para candidaturas']").click

        expect(page).to have_button('Copiar o link')
      end

      context 'when fails' do
        let(:recruitment_role_open_error_message) { 'Falha ao abrir o processo para candidaturas' }
        let(:recruitment_role_close_error_message) { 'Falha ao fechar o processo para candidaturas' }

        before do
          allow_any_instance_of(RecruitmentRole).to receive(:closed_to_applications!)
            .and_raise(recruitment_role_close_error_message)
          allow_any_instance_of(RecruitmentRole).to receive(:open_to_applications!)
            .and_raise(recruitment_role_open_error_message)
        end

        it 'shows flash error when closing applications' do
          click_button 'Ruby Developer'
          find("a[title='Fechar processo para candidaturas']").click

          expect(page).to have_content(recruitment_role_close_error_message)
        end

        it 'shows flash error when opening applications' do
          click_button 'React Developer'
          find("a[title='Abrir processo para candidaturas']").click

          expect(page).to have_content(recruitment_role_open_error_message)
        end
      end
    end

    context 'when managing application status' do
      let(:recruitment_role) { create(:recruitment_role, recruitment: recruitment, role: ruby_role) }
      let(:applications) { create_list(:application, 2, recruitment_role: recruitment_role, status: :in_process) }
      let(:first_application) { applications.first }
      let(:second_application) { applications.second }

      before do
        first_application
        second_application
        visit recruitment_path(recruitment)
      end

      context 'when allows approving an application' do
        before do
          within('tr', text: first_application.candidate.name) do
            find("button[title='#{I18n.t('applications.table.approve_candidate')}']").click
          end
        end

        it 'updates application status' do
          within('tr', text: first_application.candidate.name) do
            expect(page).to have_content(I18n.t('enumerations.application/status.approved'))
            expect(first_application.reload.status).to eq 'approved'
          end
        end
      end

      context 'when allows rejecting an application' do
        before do
          within('tr', text: second_application.candidate.name) do
            find("button[title='#{I18n.t('applications.table.reject_candidate')}']").click
          end
        end

        it 'updates application status' do
          within('tr', text: second_application.candidate.name) do
            expect(page).to have_content(I18n.t('enumerations.application/status.rejected'))
            expect(second_application.reload.status).to eq 'rejected'
          end
        end
      end

      context 'when updating application status fails' do
        let(:application_approve_error_message) { 'Falha ao aprovar a candidatura' }
        let(:application_reject_error_message) { 'Falha ao reprovar a candidatura' }

        before do
          allow_any_instance_of(Application).to receive(:approved!).and_raise(application_approve_error_message)
          allow_any_instance_of(Application).to receive(:rejected!).and_raise(application_reject_error_message)
        end

        it 'shows flash error when approving an application' do
          within('tr', text: first_application.candidate.name) do
            find("button[title='#{I18n.t('applications.table.approve_candidate')}']").click
          end

          expect(page).to have_content(application_approve_error_message)
        end

        it 'shows flash error when rejecting an application' do
          within('tr', text: second_application.candidate.name) do
            find("button[title='#{I18n.t('applications.table.reject_candidate')}']").click
          end

          expect(page).to have_content(application_reject_error_message)
        end
      end
    end

    context 'when no roles are present for the recruitment' do
      let(:recruitment_without_roles) { create(:recruitment, company: company) }

      before { visit recruitment_path(recruitment_without_roles) }

      it { expect(page).to have_content('Nenhum processo seletivo encontrado') }
    end
  end
end
