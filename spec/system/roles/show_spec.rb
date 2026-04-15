# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Roles#Show' do
  context 'when visit Roles Show' do
    let(:role) { create(:role) }

    before do
      sign_in_as_admin
      visit role_path(role)
    end

    it { expect(page).to have_current_path(role_path(role)) }
    it { expect(page).to have_link(role.company.name, href: company_path(role.company)) }
    it { expect(page).to have_content(role.name) }
    it { expect(page).to have_content(role.description) }
  end
end
