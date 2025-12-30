# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Role#New', js: true do
  context 'when visit Role New' do
    let(:company) { create(:company) }

    before do
      visit company_path(id: company.id)
      click_link 'Criar vaga'
    end

    it { expect(page).to have_current_path(company_path(id: company.id)) }
    it { expect(page).to have_content('Adicionar Nova Vaga') }
    it { expect(page).to have_field('Nome') }
    it { expect(page).to have_field('Descrição') }
    it { expect(page).to have_field('Status') }
  end
end
