class CreateRateProviders < ActiveRecord::Migration
  def change
    create_table :rate_providers do |t|
      t.integer :zip
      t.string :provider
      t.float :rate

      t.timestamps null: false
    end
  end
end
