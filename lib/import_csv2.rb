require 'csv'

file_name = 'sub_emissions.csv'

path = "#{File.expand_path(File.dirname(__FILE__))}/#{file_name}"

records = CSV.read(path, headers:true)
records.each do |row|
  SubregionEmission.create(
    name: row['name'],
    acronym: row['acronym'],
    emissions: row['emissions']
  )
end