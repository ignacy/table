require File.dirname(__FILE__) + '/parse_yaml_file'
require File.dirname(__FILE__) + '/../lib/table'
require 'yaml'

columns, rows = columns_and_rows

table = Table.new
rows.each { |row| table.rows << row }
table.columns = columns

array_of_arrays = []
array_of_arrays[0] = table.columns
table.rows.each do |row|
  array_of_arrays << row
end

File.open("s1-exam-data-transformed.yaml", 'w') {|f| f.write(YAML::dump(array_of_arrays)) }
