# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Applications::WorkflowCreator do
  include ActionDispatch::TestProcess::FixtureFile

  let(:recruitment) { create(:recruitment) }
  let(:recruitment_role) { create(:recruitment_role, recruitment: recruitment) }
  let(:candidate_params) do
    attributes_for(:candidate).merge(resume: fixture_file_upload('resume_test.pdf', 'application/pdf'))
  end

  before { recruitment_role }

  describe '.call' do
    subject(:result) { described_class.call(candidate_params, recruitment_role) }

    it 'calls method instance call' do
      expect_any_instance_of(described_class).to receive(:call).once
      result
    end
  end

  describe '#call' do
    subject(:result) { described_class.new(candidate_params, recruitment_role).call }

    context 'when success' do
      context 'when a new candidate is created' do
        it { expect { result }.to change(Candidate, :count).by(1) }
        it { expect { result }.to change(Application, :count).by(1) }

        it 'returns the application as resource' do
          expect(result[:resource]).to be_a(Application)
          expect(result[:errors]).to be_nil
        end
      end

      context 'when an existing candidate is updated' do
        let(:existing_candidate) { create(:candidate, cpf: candidate_params[:cpf]) }

        before { existing_candidate }

        it { expect { result }.not_to change(Candidate, :count) }
        it { expect { result }.to change(Application, :count).by(1) }

        it 'updates the candidate' do
          result
          expect(existing_candidate.reload.name).to eq(candidate_params[:name])
        end

        it 'returns the application as resource' do
          expect(result[:resource]).to be_a(Application)
          expect(result[:errors]).to be_nil
        end
      end
    end

    context 'when failure' do
      context 'when candidate params are invalid' do
        let(:candidate_params) do
          attributes_for(:candidate, name: nil)
            .merge(resume: fixture_file_upload('resume_test.pdf', 'application/pdf'))
        end

        it { expect { result }.not_to change(Candidate, :count) }
        it { expect { result }.not_to change(Application, :count) }

        it 'returns the candidate as resource with errors' do
          expect(result[:resource]).to be_a(Candidate)
          expect(result[:errors]).to include(' Nome não pode ficar em branco')
        end
      end

      context 'when an application error occurs' do
        before do
          allow(Application).to receive(:create!).and_raise(StandardError, 'database error')
        end

        it { expect { result }.not_to change(Candidate, :count) }
        it { expect { result }.not_to change(Application, :count) }

        it 'returns the candidate as resource with errors' do
          expect(result[:resource]).to be_a(Candidate)
          expect(result[:errors]).to eq('Ocorreu uma falha ao realizar sua candidatura')
        end
      end
    end
  end
end
