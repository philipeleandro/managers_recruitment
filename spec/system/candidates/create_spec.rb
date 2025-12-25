# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Candidates#Create' do
  before { visit new_candidate_path }

  context 'when successfully' do
    it 'creates a new candidate' do
      fill_in 'Nome', with: 'João Silva'
      fill_in 'Telefone', with: '11999999999'
      fill_in 'CPF', with: CPF.generate
      fill_in 'E-mail', with: 'user@test.com'
      attach_file 'Currículo', Rails.root.join('spec/fixtures/files/resume_test.pdf')
      click_button 'Criar Candidato'

      expect(page).to have_current_path(candidates_path)
      expect(Candidate.count).to eq(1)
    end
  end

  # context 'when fails' do
  #   it 'shows errors when data is invalid' do
  #     fill_in 'Nome', with: 'João Silva'
      # fill_in 'Telefone', with: '11999999999'
      # fill_in 'CPF', with: 'fake_cpf'
      # fill_in 'E-mail', with: 'user@test.com'
      # attach_file 'Currículo', Rails.root.join('spec/fixtures/files/resume_test.pdf')
      # click_button 'Criar Candidato'

  #     expect(page).to have_content("CPF inválido")
  #     expect(Candidate.count).to eq(0)
  #   end
  # end
end
