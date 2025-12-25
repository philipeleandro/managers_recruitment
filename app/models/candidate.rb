# frozen_string_literal: true

class Candidate < ApplicationRecord
  has_enumeration_for :status, with: Status, create_helpers: true

  has_one_attached :resume

  validates :name, :email, :cpf, :phone_number, :status, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, :cpf, uniqueness: { case_sensitive: false }
  validates :cpf, format: { with: /\A\d+\z/, message: "deve conter apenas números" }
  validates :cpf, length: { maximum: 11 }
  validates :resume, attached: true,
    content_type: ['application/pdf'],
    size: { less_than: 10.megabytes }

  validate :validate_document

  def validate_document
    return if Validator::Documents.valid_cpf?(cpf)

    errors.add(:cpf, I18n.t('activerecord.errors.not_valid'))
  end
end
