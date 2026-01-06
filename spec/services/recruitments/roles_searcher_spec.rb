# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruitments::RolesSearcher do
  let(:role_first) { create(:role) }
  let(:role_second) { create(:role) }
  let(:recruitment) { create(:recruitment) }
  let(:resource) { recruitment }
  let(:page) { 1 }

  describe '#initialize' do
    subject(:instance) { described_class.new(*params) }

    context 'when success' do
      context 'when all arguments are present' do
        let(:params) { [resource, page] }

        it { expect { instance }.not_to raise_error }
      end
    end

    context 'when fail' do
      context 'when missing arguments' do
        let(:params) { [resource] }

        it { expect { instance }.to raise_error(ArgumentError) }
      end
    end
  end

  describe '.call' do
    subject(:result) { described_class.call(**params) }

    let(:params) { { resource: resource, page: page } }

    it 'calls method instance call' do
      expect_any_instance_of(described_class).to receive(:call).once

      result
    end
  end

  describe '#call' do
    subject(:result) { instance.call }

    let(:instance) { described_class.new(resource, page) }
    let(:recruitment) { create(:recruitment) }
    let(:resource) { recruitment }

    context 'when success' do
      context 'when recruitment has associated roles' do
        let(:recruitment_role_one) { create(:recruitment_role, recruitment: recruitment, role: role_first, quantity: 1) }
        let(:recruitment_role_two) { create(:recruitment_role, recruitment: recruitment, role: role_second, quantity: 1) }

        before do
          recruitment_role_one
          recruitment_role_two
        end

        it 'returns the associated roles' do
          expect(result).to contain_exactly(role_first, role_second)
        end
      end
    end

    context 'when there are no associated roles' do
      it 'returns an empty array' do
        expect(result).to eq([])
      end
    end
  end
end
