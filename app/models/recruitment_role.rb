# frozen_string_literal: true

class RecruitmentRole < ApplicationRecord
  belongs_to :recruitment
  belongs_to :role


  has_enumeration_for :status, with: Status, create_helpers: true
end
