class AddFuelTypeToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :fuel_type, :string
  end
end
