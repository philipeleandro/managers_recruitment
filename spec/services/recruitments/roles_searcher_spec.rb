# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruitments::RolesSearcher do
  let(:role1) { create(:role) }
  let(:role2) { create(:role) }
  let(:recruitment_role) do
    create(:recruitment_role, recruitment: recruitment, roles_data: { role1.id.to_s => '1', role2.id.to_s => '1' })
  end
  let(:recruitment) { create(:recruitment) }
  let(:resource) { recruitment }
  let(:page) { 1 }

  describe '#initialize' do
    subject(:instance) { described_class.new(*params) }

    context 'when success' do
      context 'when all arguments are present' do
        let(:params) { [resource, page] }

        it { expect { instance }.not_to raise_error(ArgumentError) }
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

    context 'when success' do
      context 'when recruitment_role is present and has roles_data' do
        before do
          role1
          role2
          recruitment_role
        end

        it 'returns the roles' do
          expect(result).to contain_exactly(role1, role2)
        end
      end
    end

    context 'when fail' do
      context 'when recruitment_role is nil' do
        let(:recruitment) { create(:recruitment, recruitment_role: nil) }

        it 'returns an empty array' do
          expect(result).to eq([])
        end
      end

      context 'when roles_data is blank' do
        let(:recruitment_role) { create(:recruitment_role, roles_data: {}) }

        it 'returns an empty array' do
          expect(result).to eq([])
        end
      end
    end
  end
end
