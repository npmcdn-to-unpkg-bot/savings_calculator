class AddConversionToFuelCost < ActiveRecord::Migration
  def change
    add_column :fuel_costs, :conversion, :float
  end
end
