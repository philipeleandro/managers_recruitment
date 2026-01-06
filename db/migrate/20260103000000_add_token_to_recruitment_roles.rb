# frozen_string_literal: true

class AddTokenToRecruitmentRoles < ActiveRecord::Migration[8.1]
  def change
    add_column :recruitment_roles, :token, :string
    add_index :recruitment_roles, :token, unique: true
  end
end
