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

    context 'with recruitment_role' do
      let(:recruitment_role) { create(:recruitment_role) }
      let(:role_id) { recruitment_role.role_id }

      it { expect(quantity_for_role).to eq(recruitment_role.quantity) }
    end

    context 'without role' do
      let(:recruitment_role) { create(:recruitment_role) }
      let(:role_id) { 'fake_id' }

      it { expect(quantity_for_role).to eq(0) }
    end
  end
end
