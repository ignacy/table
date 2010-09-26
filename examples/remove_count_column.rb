require File.dirname(__FILE__) + '/parse_yaml_file'
require File.dirname(__FILE__) + '/../lib/table'
require 'yaml'

columns, rows = columns_and_rows

table = Table.new
rows.each { |row| table.rows << row }
table.columns = columns

puts table["Count"].count

table.delete_column("Count")

puts table.columns

begin
  table["Count"].count
rescue NoMethodError
  puts "theres no Count column!"
end
