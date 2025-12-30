# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company do
  describe 'validations' do
    subject(:company) { build(:company) }

    it { expect(company).to validate_presence_of(:email) }
    it { expect(company).to validate_presence_of(:cnpj) }
    it { expect(company).to validate_presence_of(:responsible_name) }
    it { expect(company).to validate_presence_of(:phone_number) }
    it { expect(company).to validate_presence_of(:status) }
    it { expect(company).to validate_presence_of(:name) }

    it { expect(company).to validate_uniqueness_of(:email).case_insensitive }
    it { expect(company).to validate_uniqueness_of(:cnpj).case_insensitive }

    it { expect(company).to validate_length_of(:cnpj).is_at_most(14) }

    it { expect(company).not_to allow_value('123.456.789/0001-12').for(:cnpj) }
    it { expect(company).not_to allow_value('abcde123456').for(:cnpj) }

    context 'when email format is invalid' do
      let(:company_invalid_email) { build(:company, email: 'invalid_email') }
      let(:error_messages) { company_invalid_email.errors.full_messages_for(:email) }

      before { company_invalid_email.valid? }

      it { expect(error_messages).to include('E-mail não é válido') }
    end

    context 'when cnpj is invalid' do
      let(:company_invalid_cnpj) { build(:company, cnpj: '12345678900231') }
      let(:error_messages) { company_invalid_cnpj.errors.full_messages_for(:cnpj) }

      before { company_invalid_cnpj.valid? }

      it { expect(error_messages).to include('CNPJ não é válido') }
    end
  end
end
