# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :roles, dependent: :destroy
  has_many :recruitments, dependent: :destroy

  has_enumeration_for :status, with: Status, create_helpers: true

  validates :name, :email, :cnpj, :responsible_name, :phone_number, :status, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, :cnpj, uniqueness: { case_sensitive: false }
  validates :cnpj, length: { maximum: 14 }

  validate :validate_document

  def validate_document
    return if Validator::Documents.valid_cnpj?(cnpj)

    errors.add(:cnpj, I18n.t('activerecord.errors.not_valid'))
  end
end
