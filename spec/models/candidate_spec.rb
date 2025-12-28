# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidate do
  describe 'validations' do
    subject(:candidate) { build(:candidate) }

    it { expect(candidate).to validate_presence_of(:email) }
    it { expect(candidate).to validate_presence_of(:cpf) }
    it { expect(candidate).to validate_presence_of(:name) }
    it { expect(candidate).to validate_presence_of(:phone_number) }
    it { expect(candidate).to validate_presence_of(:status) }

    it { expect(candidate).to validate_uniqueness_of(:email).case_insensitive }
    it { expect(candidate).to validate_uniqueness_of(:cpf).case_insensitive }

    it { expect(candidate).to validate_length_of(:cpf).is_at_most(11) }

    it { expect(candidate).not_to allow_value('123.456.789-00').for(:cpf) }
    it { expect(candidate).not_to allow_value('abcde123456').for(:cpf) }

    context 'when email format is invalid' do
      let(:candidate) { build(:candidate, email: 'invalid_email') }
      let(:error_messages) { candidate.errors.full_messages_for(:email) }

      before { candidate.valid? }

      it { expect(error_messages).to include('E-mail não é válido') }
    end

    context 'when cpf is invalid' do
      let(:candidate) { build(:candidate, cpf: '12345678900') }
      let(:error_messages) { candidate.errors.full_messages_for(:cpf) }

      before { candidate.valid? }

      it { expect(error_messages).to include('CPF não é válido') }
    end
  end

  describe 'validates attached file' do
    let(:candidate) { create(:candidate) }

    it 'is valid' do
      expect(candidate).to be_valid
    end

    context 'when format is not valid' do
      let(:candidate) { build(:candidate) }

      context 'when format is .txt' do
        before do
          candidate.resume.attach(
            io: StringIO.new('resume'),
            filename: 'resume.txt',
            content_type: 'text/plain'
          )
        end

        it { expect(candidate).not_to be_valid }
      end
    end

    context 'when size greater than 10mb' do
      let(:candidate) { build(:candidate) }

      before do
        candidate.resume.attach(
          io: StringIO.new('resume' * 12.megabytes),
          filename: 'resume.pdf',
          content_type: 'application/pdf'
        )
      end

      it { expect(candidate).not_to be_valid }
    end
  end

  describe 'callbacks' do
    subject(:candidate) { create(:candidate) }

    describe 'before_destroy' do
      describe '#purge_resume' do
        let(:blob_attachment_id) { candidate.resume.blob.id }

        before do
          blob_attachment_id
          candidate.destroy
        end

        it { expect(ActiveStorage::Blob.find_by(id: blob_attachment_id)).to be_nil }
        it { expect(ActiveStorage::Attachment.find_by(id: blob_attachment_id)).to be_nil }
        it { expect(described_class.count).to be(0) }
      end
    end
  end
end
