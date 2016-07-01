require 'csv'

file_name = 'rate_provider.csv'

path = "#{File.expand_path(File.dirname(__FILE__))}/#{file_name}"

records = CSV.read(path, headers:true)
records.each do |row|
  RateProvider.create(
    zip: row['zip'],
    provider: row['provider'],
    rate: row['rate']
  )
end