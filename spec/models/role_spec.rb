# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role do
  describe 'validations' do
    subject(:role) { build(:role) }

    it { expect(role).to validate_presence_of(:name) }
    it { expect(role).to validate_presence_of(:description) }
    it { expect(role).to validate_presence_of(:status) }

    it { expect(role).to belong_to(:company) }
  end
end
