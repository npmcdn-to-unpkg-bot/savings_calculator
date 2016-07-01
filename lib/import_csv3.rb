require 'csv'

file_name = 'zip_sub.csv'

path = "#{File.expand_path(File.dirname(__FILE__))}/#{file_name}"

records = CSV.read(path, headers:true)
records.each do |row|
  ZipSubregion.create(
    zip: row['zip'],
    primary_sub: row['primary_sub'],
    secondary_sub: row['secondary_sub']
  )
end