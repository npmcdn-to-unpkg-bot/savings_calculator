class CreateFuelCosts < ActiveRecord::Migration
  def change
    create_table :fuel_costs do |t|
      t.string :fuel_type
      t.float :cost

      t.timestamps null: false
    end
  end
end
