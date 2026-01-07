# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Role#New', js: true do
  context 'when accesses company view' do
    let(:company) { create(:company) }

    before do
      visit company_path(id: company.id)
      click_link 'Criar cargo'
    end

    it { expect(page).to have_current_path(company_path(id: company.id)) }
    it { expect(page).to have_content('Adicionar Novo Cargo') }
    it { expect(page).to have_field('Nome') }
    it { expect(page).to have_field('Descrição') }
    it { expect(page).to have_field('Status') }
  end

  context 'when accesses role view' do
    before do
      visit roles_path
      click_link 'Criar Cargo'
    end

    it { expect(page).to have_current_path(roles_path) }
    it { expect(page).to have_content('Adicionar Novo Cargo') }
    it { expect(page).to have_field('Nome') }
    it { expect(page).to have_field('Descrição') }
    it { expect(page).to have_field('Status') }
    it { expect(page).to have_field('Empresa') }
  end
end
