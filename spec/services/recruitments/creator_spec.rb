# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruitments::Creator, type: :service do
  let!(:company) { create(:company) }
  let!(:role_first) { create(:role) }
  let!(:role_second) { create(:role) }

  let(:recruitment_params) do
    {
      description: 'New recruitment process',
      company_id: company.id,
      status: 'new',
      value: 5000,
      opening_date: Date.current,
      finish_date: Date.current + 1.month
    }
  end

  let(:roles_data) do
    {
      roles_data: {
        role_first.id.to_s => '2',
        role_second.id.to_s => '1',
        'other_role' => '0'
      }
    }
  end

  let(:valid_params) { { recruitment: recruitment_params.merge(recruitment_role_attributes: roles_data) } }
  let(:invalid_params) do
    { recruitment: recruitment_params.except(:description).merge(recruitment_role_attributes: roles_data) }
  end

  before do
    company
    role_first
    role_second
  end

  describe '.call' do
    it 'initializes and calls the service' do
      expect_any_instance_of(described_class).to receive(:call)
      described_class.call(valid_params)
    end
  end

  describe '#call' do
    subject(:service_call) { described_class.new(ActionController::Parameters.new(params)).call }

    context 'with valid params' do
      let(:params) { valid_params }

      context 'when creates a new Recruitment record' do
        it { expect { service_call }.to change(Recruitment, :count).by(1) }
      end

      context 'when assigns correct attributes to the Recruitment' do
        subject(:resource) { service_call[:resource] }

        it { expect(resource.description).to eq('New recruitment process') }
        it { expect(resource.company).to eq(company) }
        it { expect(resource.status).to eq('new') }
      end

      context 'when creates the associated RecruitmentRole records' do
        it { expect { service_call }.to change(RecruitmentRole, :count).by(2) }
      end

      context 'when assigns correct roles and quantities' do
        subject(:resource) { service_call[:resource] }

        it { expect(resource.recruitment_roles.find_by(role: role_first).quantity).to eq(2) }
        it { expect(resource.recruitment_roles.find_by(role: role_second).quantity).to eq(1) }
      end

      context 'when returns the created recruitment and no errors' do
        subject(:result) { service_call }

        it { expect(result[:resource]).to be_a(Recruitment) }
        it { expect(result[:resource]).to be_persisted }
        it { expect(result[:errors]).to be_nil }
      end
    end

    context 'with invalid params' do
      let(:params) { invalid_params }

      it 'does not create a new Recruitment record' do
        expect { service_call }.not_to change(Recruitment, :count)
      end

      it 'does not create new RecruitmentRole records' do
        expect { service_call }.not_to change(RecruitmentRole, :count)
      end

      context 'when returns the unsaved recruitment and errors' do
        subject(:result) { service_call }

        it { expect(result[:resource]).to be_a(Recruitment) }
        it { expect(result[:resource]).not_to be_persisted }
        it { expect(result[:errors]).to include(' Descrição não pode ficar em branco') }
      end
    end

    context 'when a standard error is raised' do
      let(:params) { valid_params }

      before do
        allow_any_instance_of(described_class).to receive(:recruitment_roles_creation).and_raise(
          StandardError,
          'Something went wrong'
        )
      end

      it 'does not create a new Recruitment record due to transaction rollback' do
        expect { service_call }.not_to change(Recruitment, :count)
      end

      context 'when returns an error message' do
        subject(:result) { service_call }

        it { expect(result[:resource]).to be_an_instance_of(Recruitment) }
        it { expect(result[:errors]).to eq('Something went wrong') }
      end
    end
  end
end
