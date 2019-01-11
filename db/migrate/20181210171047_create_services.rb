class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name
      t.integer :department_id
      t.integer :program_id
      t.integer :agency_id

      t.timestamps
    end
  end
end
