require 'rails_helper'

RSpec.describe Application do
  subject(:application) { build(:application) }

  describe 'associations' do
    it { expect(application).to belong_to(:recruitment_role) }
    it { expect(application).to belong_to(:candidate) }
  end
end
