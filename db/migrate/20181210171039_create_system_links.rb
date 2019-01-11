class CreateSystemLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :system_links do |t|
      t.integer :system_a_id
      t.integer :system_b_id
      t.string :protocol
      t.integer :weight

      t.timestamps
    end
  end
end
