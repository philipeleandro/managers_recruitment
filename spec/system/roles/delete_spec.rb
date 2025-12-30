# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Role#delete', js: true do
  let(:role) { create(:role) }

  before do
    role
    visit roles_path
  end

  context 'when successfully' do
    it 'deletes a role' do
      accept_confirm do
        click_link 'delete-role-button'
      end

      expect(page).to have_current_path(roles_path)
      expect(page).to have_content('Vaga excluída com sucesso')
      expect(Role.count).to eq(0)
    end
  end
end
