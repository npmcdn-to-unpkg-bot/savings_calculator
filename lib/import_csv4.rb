require 'csv'

file_name = 'fuelcost.csv'

path = "#{File.expand_path(File.dirname(__FILE__))}/#{file_name}"

records = CSV.read(path, headers:true)
records.each do |row|
  FuelCost.create(
    fuel_type: row['fuel_type'],
    cost: row['cost'],
    conversion: row['conversion']
  )
end