# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Companies::Filter do
  let(:resource_active) { create(:company, status: :active) }
  let(:resource_inactive) { create(:company, status: :inactive) }

  describe '#initialize' do
    subject(:instance) { described_class.new(*params) }

    context 'when success' do
      context 'when all arguments are present' do
        let(:params) { [resource_active.cnpj, 'active', 1] }

        it { expect { instance }.not_to raise_error }
      end
    end

    context 'when fail' do
      context 'when missing arguments' do
        let(:params) { [resource_active.cnpj, 'active'] }

        it { expect { instance }.to raise_error(ArgumentError) }
      end
    end
  end

  describe '.call' do
    subject(:result) { described_class.call(**params) }

    let(:params) { { query: resource_active.cnpj, status: 'active', page: 1 } }

    it 'calls method instance call' do
      expect_any_instance_of(described_class).to receive(:call).once

      result
    end
  end

  describe '#call' do
    subject(:result) { instance.call }

    let(:instance) { described_class.new(*params) }

    before do
      resource_active
      resource_inactive
    end

    context 'when success' do
      context 'when query is blank' do
        let(:params) { [nil, nil, 1] }

        it { expect(result.size).to eq 2 }
      end

      context 'when query is present' do
        let(:params) { [resource_active.cnpj, :active, 1] }

        it { expect(result.size).to eq 1 }
      end

      context 'when has status' do
        let(:params) { [resource_active.name, :active, 1] }

        it { expect(result.size).to eq 1 }
      end

      context 'when does not have status' do
        let(:params) { [resource_active.cnpj, nil, 1] }

        it { expect(result.size).to eq 1 }
      end
    end
  end
end
