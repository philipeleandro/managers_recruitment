# frozen_string_literal: true

class Role < ApplicationRecord
  belongs_to :company

  has_enumeration_for :status, with: Status, create_helpers: true

  validates :name, :description, :status, presence: true
end
