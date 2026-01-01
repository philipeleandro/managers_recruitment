class CreateRecruitmentRoles < ActiveRecord::Migration[8.1]
  def change
    create_table :recruitment_roles do |t|
      t.jsonb :roles_data, default: {}, null: false
      t.references :recruitment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
