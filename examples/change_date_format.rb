require File.dirname(__FILE__) + '/parse_yaml_file'
require File.dirname(__FILE__) + '/../lib/table'
require 'yaml'

columns, rows = columns_and_rows

table = Table.new
rows.each { |row| table.rows << row }
table.columns = columns

table.rows.each do |row|
  date = Date.strptime(row[0], '%m/%d/%y')
  row[0] = date.strftime("%Y-%m-%d")
end

puts table.cell(1000, 0)
