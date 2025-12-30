# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recruitment#New' do
  context 'when visit Recruitment New', js: true do
    let(:company) { create(:company) }

    before do
      visit company_path(id: company.id)
      click_link 'Criar Processo Seletivo'
    end

    it { expect(page).to have_content('Adicionar Novo Processo Seletivo') }
    it { expect(page).to have_field('Descrição') }
    it { expect(page).to have_field('Data de início') }
    it { expect(page).to have_field('Data de término') }
    it { expect(page).to have_field('Valor') }
  end
end
