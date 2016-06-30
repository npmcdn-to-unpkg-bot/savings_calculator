class AddEmissionsToFuelCost < ActiveRecord::Migration
  def change
    add_column :fuel_costs, :emissions, :float
  end
end
