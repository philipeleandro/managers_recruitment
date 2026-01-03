# frozen_string_literal: true

class CreateRecruitmentRoles < ActiveRecord::Migration[8.1]
  def change
    create_table :recruitment_roles do |t|
      t.references :role, null: false, foreign_key: true
      t.references :recruitment, null: false, foreign_key: true
      t.integer :quantity, default: 0
      t.string :status, null: false, default: 'new'

      t.timestamps
    end
  end
end
