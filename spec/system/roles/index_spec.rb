# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Role#Index' do
  context 'when visit Role Index' do
    context 'when there is Role' do
      let(:role) { create(:role) }

      before do
        role
        visit roles_path
      end

      it { expect(page).to have_current_path(roles_path) }
      it { expect(page).to have_content('Lista de Vagas') }
      it { expect(page).to have_content('Nome') }
      it { expect(page).to have_content('Status') }
      it { expect(page).to have_content('Ações') }

      context 'with filter', js: true do
        before do
          fill_in 'query', with: role.name
          find('input[name="query"]').send_keys(:enter)
        end

        it { expect(page).to have_content('Lista de Vagas') }
        it { expect(page).to have_content(role.name) }
      end
    end

    context 'when there is no roles' do
      before { visit roles_path }

      it { expect(page).to have_current_path(roles_path) }
      it { expect(page).to have_content('Lista de Vagas') }
      it { expect(page).to have_content('Nenhuma vaga encontrada') }
    end
  end
end
