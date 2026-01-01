require 'rails_helper'

RSpec.describe RecruitmentRole do
  subject(:recruitment_role) { build(:recruitment_role) }

  describe 'associations' do
    it { expect(recruitment_role).to belong_to(:recruitment) }
  end
end
