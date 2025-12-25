# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Candidates#delete' do # js: true do
  let(:candidate) { create(:candidate) }

  before { visit candidates_path }

  context 'when successfully' do
    it 'deletes a candidate' do
      accept_confirm do
        click_link 'delete-candidate-button'
      end

      expect(page).to have_current_path(candidates_path)
      expect(page).to have_content('Candidato excluído com sucesso')
      expect(Candidate.count).to eq(0)
    end
  end
end
