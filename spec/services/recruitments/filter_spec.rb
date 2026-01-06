# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruitments::Filter do
  let(:company_first) { create(:company) }
  let(:company_second) { create(:company) }
  let(:recruitment_new) { create(:recruitment, status: :new, company: company_first) }
  let(:recruitment_in_progress) { create(:recruitment, status: :in_progress, company: company_first) }
  let(:recruitment_finished) { create(:recruitment, status: :finished, company: company_second) }

  describe '#initialize' do
    subject(:instance) { described_class.new(*params) }

    context 'when success' do
      context 'when all arguments are present' do
        let(:params) { ['new', 1, 'created_at', 'desc', company_first.id] }

        it { expect { instance }.not_to raise_error }
      end
    end

    context 'when fail' do
      context 'when missing arguments' do
        let(:params) { ['new', 1, 'created_at', 'desc'] }

        it { expect { instance }.to raise_error(ArgumentError) }
      end
    end
  end

  describe '.call' do
    subject(:result) { described_class.call(**params) }

    let(:params) { { status: 'new', page: 1, sort: 'created_at', direction: 'desc', company_id: company_first.id } }

    it 'calls method instance call' do
      expect_any_instance_of(described_class).to receive(:call).once

      result
    end
  end

  describe '#call' do
    subject(:result) { instance.call }

    let(:instance) { described_class.new(*params) }

    before do
      recruitment_new
      recruitment_in_progress
      recruitment_finished
    end

    context 'when success' do
      context 'when status is blank and company_id is blank' do
        let(:params) { [nil, 1, nil, nil, nil] }

        it { expect(result.size).to eq 3 }
      end

      context 'when status is present' do
        let(:params) { [:new, 1, nil, nil, nil] }

        it { expect(result.size).to eq 1 }
      end

      context 'when company_id is present' do
        let(:params) { [nil, 1, nil, nil, company_first.id] }

        it { expect(result.size).to eq 2 }
      end

      context 'when status and company_id are present' do
        let(:params) { [:in_progress, 1, nil, nil, company_first.id] }

        it { expect(result.size).to eq 1 }
      end

      context 'when sort and direction are present' do
        let(:params) { [nil, 1, 'created_at', 'asc', nil] }

        it { expect(result.size).to eq 3 }
        it { expect(result.first).to eq recruitment_new }
      end
    end
  end
end
