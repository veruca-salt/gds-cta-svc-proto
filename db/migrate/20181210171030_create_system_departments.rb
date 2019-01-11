class CreateSystemDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :system_departments do |t|
      t.integer :system_id
      t.integer :department_id

      t.timestamps
    end
  end
end
