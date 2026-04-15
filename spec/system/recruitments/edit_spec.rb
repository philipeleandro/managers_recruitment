# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recruitment#edit' do
  context 'when visit Recruitment edit', js: true do
    let(:company) { create(:company) }
    let(:recruitment) { create(:recruitment, company: company) }

    before do
      sign_in_as_admin
      recruitment

      visit company_path(id: company.id)
      find('#edit-recruitment-button', match: :first).click
    end

    it { expect(page).to have_content('Editar Processo Seletivo') }
    it { expect(page).to have_field('Descrição') }
    it { expect(page).to have_field('Data de início') }
    it { expect(page).to have_field('Data de término') }
    it { expect(page).to have_field('Valor') }
  end
end
