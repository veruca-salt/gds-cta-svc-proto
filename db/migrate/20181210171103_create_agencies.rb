class CreateAgencies < ActiveRecord::Migration[5.2]
  def change
    create_table :agencies do |t|
      t.string :name

      t.timestamps
    end
  end
end
