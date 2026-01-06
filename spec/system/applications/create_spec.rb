# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application#Create' do
  let(:recruitment_role) { create(:recruitment_role, status: RecruitmentRole::Status::OPEN_TO_APPLICATIONS) }

  before { visit apply_path(token: recruitment_role.token) }

  context 'when successfully' do
    before do
      fill_in 'Nome', with: 'João Silva'
      fill_in 'E-mail', with: 'user@test.com'
      fill_in 'CPF', with: CPF.generate
      fill_in 'Telefone', with: '11999999999'
      attach_file 'Currículo', Rails.root.join('spec/fixtures/files/resume_test.pdf')
      click_button 'Candidatar-se'
    end

    it { expect(page).to have_current_path(apply_path(token: recruitment_role.token)) }
    it { expect(page).to have_content('Candidatura enviada com sucesso') }
    it { expect(Application.count).to eq(1) }
    it { expect(Candidate.count).to eq(1) }
  end

  context 'when fails' do
    it 'shows errors when data is invalid' do
      fill_in 'Nome', with: ''
      fill_in 'E-mail', with: 'user@test.com'
      fill_in 'CPF', with: CPF.generate
      fill_in 'Telefone', with: '11999999999'
      attach_file 'Currículo', Rails.root.join('spec/fixtures/files/resume_test.pdf')
      click_button 'Candidatar-se'

      expect(page).to have_content('Nome não pode ficar em branco')
      expect(Application.count).to eq(0)
      expect(Candidate.count).to eq(0)
    end
  end
end
