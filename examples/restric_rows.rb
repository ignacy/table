require File.dirname(__FILE__) + '/parse_yaml_file'
require File.dirname(__FILE__) + '/../lib/table'
require 'yaml'

columns, rows = columns_and_rows

table = Table.new
rows.each { |row| table.rows << row }
table.columns = columns

selected = table.select_rows { |r| Date.strptime(r[0], '%m/%d/%y').month == 6 }
puts "Found #{selected.count} rows"
