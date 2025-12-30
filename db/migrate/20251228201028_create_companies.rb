class CreateCompanies < ActiveRecord::Migration[8.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :cnpj
      t.string :responsible_name
      t.string :phone_number
      t.string :email
      t.string :status, default: 'new', null: false

      t.timestamps
    end
  end
end
