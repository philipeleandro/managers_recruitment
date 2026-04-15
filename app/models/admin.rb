# frozen_string_literal: true

class Admin < ApplicationRecord
  has_enumeration_for :status, with: Status, create_helpers: true

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
end
