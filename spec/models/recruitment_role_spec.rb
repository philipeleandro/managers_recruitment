# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecruitmentRole do
  subject(:recruitment_role) { build(:recruitment_role) }

  describe 'associations' do
    it { expect(recruitment_role).to belong_to(:recruitment) }
  end

  describe '#remove_empty_roles' do
    subject(:recruitment_role) { create(:recruitment_role, roles_data: roles_data) }

    context 'when roles_data is empty' do
      let(:roles_data) { {} }

      it { expect(recruitment_role.roles_data).to eq(roles_data) }
    end

    context 'when roles_data has role with zero quantity' do
      let(:roles_data) { { '1' => '0', '2' => '3' } }
      let(:expected_result) { { '2' => '3' } }

      it { expect(recruitment_role.roles_data).to eq(expected_result) }
    end
  end
end
