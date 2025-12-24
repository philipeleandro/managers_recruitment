# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboards#Home' do
  context 'when visit dashboards home' do
    before { visit root_path }

    it { expect(page).to have_current_path(root_path) }
    it { expect(page).to have_content('Processos Abertos') }
    it { expect(page).to have_content('Bem vindo de volta') }
  end
end
