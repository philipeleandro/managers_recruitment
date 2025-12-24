# frozen_string_literal: true

class CreateCandidates < ActiveRecord::Migration[8.1]
  def change
    create_table :candidates do |t|
      t.string :email
      t.string :name
      t.string :cpf
      t.string :phone_number
      t.string :status, default: 'new', null: false

      t.timestamps
    end
  end
end
