# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Role#New' do
  context 'when visit Role New' do
    before { visit new_role_path }

    it { expect(page).to have_current_path(new_role_path) }
    it { expect(page).to have_content('Adicionar Nova Vaga') }
    it { expect(page).to have_field('Nome') }
    it { expect(page).to have_field('Descrição') }
    it { expect(page).to have_field('Status') }
  end
end
