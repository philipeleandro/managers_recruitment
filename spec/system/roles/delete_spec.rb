# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Roles#delete', js: true do
  let(:role) { create(:role) }
  let(:company) { role.company }

  before do
    role
    visit roles_path
  end

  context 'when successful' do
    it 'deletes a role' do
      accept_confirm do
        find_by_id('delete-role-button').click
      end

      expect(page).to have_current_path(company_path(company))
      expect(page).to have_text('Candidato excluído com sucesso')
      expect(Role.count).to be_zero
    end
  end

  context 'when it fails because of dependent recruitment_roles' do
    let(:recruitment_role) { create(:recruitment_role, role_id: role.id) }
    let(:company_of_role_with_dependency) { role.company }

    before do
      recruitment_role
      company_of_role_with_dependency
      visit roles_path
    end

    it 'does not delete the role' do
      accept_confirm do
        find_by_id('delete-role-button').click
      end

      expect(page).to have_current_path(company_path(company_of_role_with_dependency))
      expect(page).to have_text('Não é possível excluir o registro pois existem recruitment roles dependentes')
      expect(Role.count).to eq(1)
    end
  end
end
