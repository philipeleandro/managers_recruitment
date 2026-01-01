# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruitment do
  subject(:recruitment) { build(:recruitment) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_presence_of(:opening_date) }

    it { is_expected.to validate_numericality_of(:value).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:company) }
  end

  describe '#quantity_for_role' do
    subject(:quantity_for_role) { recruitment.quantity_for_role(role_id) }

    let(:recruitment) { recruitment_role.recruitment }

    context 'when recruitment_role has role_id' do
      let(:role_id) { recruitment_role.roles_data.keys.first }
      let(:recruitment_role) { create(:recruitment_role) }

      it { expect(quantity_for_role).to eq(recruitment_role.roles_data[role_id.to_s].to_i) }
    end

    context 'when recruitment_role does not have role_id' do
      let(:role_id) { 'fake_id' }
      let(:recruitment_role) { create(:recruitment_role, roles_data: {}) }

      it { expect(quantity_for_role).to eq(0) }
    end
  end
end
