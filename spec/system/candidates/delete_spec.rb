# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Candidates#delete', js: true do
  context 'when successful' do
    let(:candidate) { create(:candidate) }

    before do
      candidate
      visit candidates_path
    end

    it 'deletes a candidate' do
      accept_confirm do
        find_by_id('delete-candidate-button').click
      end

      expect(page).to have_current_path(candidates_path)
      expect(page).to have_text(I18n.t('candidates.delete.flashes.success'))
      expect(Candidate.count).to be_zero
    end
  end

  context 'when fails' do
    let!(:application) { create(:application) }
    let(:candidate) { application.candidate }

    before do
      application
      visit candidates_path
    end

    it 'does not delete the candidate' do
      accept_confirm do
        find_by_id('delete-candidate-button').click
      end

      expect(page).to have_current_path(candidates_path)
      expect(page).to have_text('Não é possível excluir o registro pois existem applications dependentes')
      expect(Candidate.count).to eq(1)
    end
  end
end
