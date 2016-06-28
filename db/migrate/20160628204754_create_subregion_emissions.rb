class CreateSubregionEmissions < ActiveRecord::Migration
  def change
    create_table :subregion_emissions do |t|
      t.string :name
      t.string :acronym
      t.float :emissions

      t.timestamps null: false
    end
  end
end
