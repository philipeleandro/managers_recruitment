# frozen_string_literal: true

class CreateRecruitments < ActiveRecord::Migration[8.1]
  def change
    create_table :recruitments do |t|
      t.string :description
      t.string :status, default: 'new', null: false
      t.date :opening_date
      t.date :finish_date
      t.decimal :value
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end

    add_index :recruitments, %i[opening_date finish_date], name: 'index_recruitments_on_opening_and_finish_date'
  end
end
