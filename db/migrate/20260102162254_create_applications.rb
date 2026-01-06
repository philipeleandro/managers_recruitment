# frozen_string_literal: true

class CreateApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :applications do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :recruitment_role, null: false, foreign_key: true
      t.string :status, default: 'in_process', null: false

      t.timestamps
    end
  end
end
