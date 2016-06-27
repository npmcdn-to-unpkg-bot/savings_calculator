class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :monthly_energy_usage
      t.integer :zip
      t.string :provider
      t.string :subregion

      t.timestamps null: false
    end
  end
end
