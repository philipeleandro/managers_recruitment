# frozen_string_literal: true

class RecruitmentRole < ApplicationRecord
  belongs_to :recruitment

  before_save :remove_empty_roles

  private

  def remove_empty_roles
    array_roles_data = roles_data.to_a
    cleaned_roles_data = array_roles_data.map { |role_data| role_data unless role_data.last.to_i.zero? }

    self.roles_data = cleaned_roles_data.compact.to_h
  end
end
