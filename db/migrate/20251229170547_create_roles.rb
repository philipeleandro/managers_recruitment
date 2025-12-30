class CreateRoles < ActiveRecord::Migration[8.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.text :description
      t.string :status, default: 'active', null: false
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
