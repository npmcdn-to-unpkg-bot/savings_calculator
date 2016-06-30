class AddFuelUsageToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :fuel_usage, :float
  end
end
