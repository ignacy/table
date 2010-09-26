require File.dirname(__FILE__) + '/parse_yaml_file'
require File.dirname(__FILE__) + '/../lib/table'
require 'yaml'

columns, rows = columns_and_rows

table = Table.new
rows.each { |row| table.rows << row }
table.columns = columns


def to_money(c)
  "$#{'%.2f' % (c.to_i/100)}"
end

table.transform_column("AMOUNT") { |n| to_money(n) }
table.transform_column("TARGET_AMOUNT") { |n| to_money(n) }
table.transform_column("AMTPINSPAID") { |n| to_money(n) }

puts table["AMOUNT"][100]
puts table["TARGET_AMOUNT"][1010]
puts table["AMTPINSPAID"][1132]
