class CreateHeatingEmissions < ActiveRecord::Migration
  def change
    create_table :heating_emissions do |t|
      t.string :source
      t.float :emissions

      t.timestamps null: false
    end
  end
end
