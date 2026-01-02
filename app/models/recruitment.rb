# frozen_string_literal: true

class Recruitment < ApplicationRecord
  belongs_to :company
  has_one :recruitment_role, dependent: :destroy

  accepts_nested_attributes_for :recruitment_role, allow_destroy: true

  has_enumeration_for :status, with: Status, create_helpers: true

  validates :description, :status, :opening_date, :finish_date, :value, presence: true
  validates :value, numericality: { greater_than_or_equal_to: 0 }

  scope :opening, -> { where(status: Status::NEW) }
  scope :in_progress, -> { where(status: Status::IN_PROGRESS) }
  scope :finished, -> { where(status: Status::FINISHED) }
  scope :new_and_in_progress, -> { where(status: [Status::NEW, Status::IN_PROGRESS]) }
  scope :recruitment_roles_included, -> {  includes(:recruitment_role) }

  def quantity_for_role(role_id)
    return 0 unless recruitment_role&.roles_data

    recruitment_role.roles_data[role_id.to_s].to_i
  end
end
