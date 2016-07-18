require 'csv'

file_name = 'fuelcostraw.csv'

path = "#{File.expand_path(File.dirname(__FILE__))}/#{file_name}"

records = CSV.read(path, headers:true)
records.each do |row|
  RateProvider.create(
    fuel_type: row['fuel_type'],
    cost: row['cost'],
    conversion: row['conversion']
  )
end