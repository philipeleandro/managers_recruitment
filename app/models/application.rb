# frozen_string_literal: true

class Application < ApplicationRecord
  has_enumeration_for :status, with: Status, create_helpers: true

  belongs_to :candidate
  belongs_to :recruitment_role

  scope :by_candidate, ->(candidate_id) { where(candidate_id: candidate_id) }

  scope :by_recruitment_and_role, lambda { |recruitment_id, role_id|
    joins(:recruitment_role)
      .where(recruitment_roles: {
        recruitment_id: recruitment_id, role_id: role_id
      }
            )
  }

  scope :by_recruitment, lambda { |recruitment_id|
    joins(:recruitment_role)
      .where(recruitment_roles: {
        recruitment_id: recruitment_id
      }
            )
  }
end
