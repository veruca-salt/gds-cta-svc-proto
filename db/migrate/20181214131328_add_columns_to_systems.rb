class AddColumnsToSystems < ActiveRecord::Migration[5.2]
  def change
    add_column :systems, :acronymn, :string
    add_column :systems, :description, :string
  end
end
