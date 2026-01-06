# frozen_string_literal: true

class Recruitment < ApplicationRecord
  belongs_to :company
  has_many :recruitment_roles, dependent: :destroy
  has_many :roles, through: :recruitment_roles

  has_enumeration_for :status, with: Status, create_helpers: true

  validates :description, :status, :opening_date, :finish_date, :value, presence: true
  validates :value, numericality: { greater_than_or_equal_to: 0 }

  scope :opening, -> { where(status: Status::NEW) }
  scope :in_progress, -> { where(status: Status::IN_PROGRESS) }
  scope :finished, -> { where(status: Status::FINISHED) }
  scope :new_and_in_progress, -> { where(status: [Status::NEW, Status::IN_PROGRESS]) }

  scope :last_month_in_progress, -> {
    where(
      status: Status::IN_PROGRESS,
      created_at: (Date.current - 30.days)..Date.current.end_of_day
    )
  }

  scope :last_month_opening, -> {
    where(
      status: Status::NEW,
      created_at: (Date.current - 30.days)..Date.current.end_of_day
    )
  }


  def quantity_for_role(role_id)
    recruiment_role = recruitment_roles.find_by(role_id: role_id)

    return 0 if recruiment_role.nil?

    recruiment_role.quantity
  end
end
