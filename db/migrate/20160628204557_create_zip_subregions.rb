class CreateZipSubregions < ActiveRecord::Migration
  def change
    create_table :zip_subregions do |t|
      t.integer :zip
      t.string :primary_sub
      t.string :secondary_sub

      t.timestamps null: false
    end
  end
end
