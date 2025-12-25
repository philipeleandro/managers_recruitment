# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Candidates#update' do
  let(:candidate) { create(:candidate) }

  before { visit edit_candidate_path(id: candidate.id) }

  context 'when successfully' do
    it 'updates a candidate' do
      fill_in 'Nome', with: 'João Silva'
      click_button 'Atualizar Candidato'

      expect(page).to have_current_path(candidates_path)
      expect(page).to have_content('João Silva')
    end
  end

  # context 'when successfully' do
  #   let(:old_cpf) { candidate.cpf }

  #   it 'updates a candidate' do
  #     fill_in 'CPF', with: 'fake_cpf'
  #     click_button 'Atualizar Candidato'

  #     expect(page).to have_current_path(candidate_path(id: candidate.id))
  #     expect(page).to have_content(old_cpf)
  #   end
  # end
end
