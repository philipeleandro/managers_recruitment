class Recruitment < ApplicationRecord
  belongs_to :company

  has_enumeration_for :status, with: Status, create_helpers: true

  validates :description, :status, :opening_date, :finish_date, :value, presence: true
  validates :value, numericality: { greater_than_or_equal_to: 0 }
end
