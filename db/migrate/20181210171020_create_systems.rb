class CreateSystems < ActiveRecord::Migration[5.2]
  def change
    create_table :systems do |t|
      t.string :name
      t.integer :importance

      t.timestamps
    end
  end
end
