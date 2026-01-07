# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Application#New' do
  context 'when open to applications' do
    let(:recruitment_role) { create(:recruitment_role, status: :open_to_applications) }

    before do
      visit apply_path(token: recruitment_role.token)

      click_button 'Candidatar-se'
    end

    it { expect(page).to have_content("Cargo: #{recruitment_role.role.name}") }
    it { expect(page).to have_content('Nome') }
    it { expect(page).to have_content('E-mail') }
    it { expect(page).to have_content('Telefone') }
    it { expect(page).to have_content('Currículo') }
    it { expect(page).to have_content('CPF') }
  end

  context 'when application is not open' do
    let(:recruitment_role) { create(:recruitment_role, status: :new) }

    before { visit apply_path(token: recruitment_role.token) }

    it { expect(page).to have_content('Não conseguimos localizar o processo seletivo') }
    it { expect(page).to have_content('Em caso de dúvidas, entre em contato com o recrutador.') }
  end
end
