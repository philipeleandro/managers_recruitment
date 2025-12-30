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
end
