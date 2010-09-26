require 'yaml'
def columns_and_rows
  
  data_file = File.dirname(__FILE__) + '/../s1-exam-data.yaml'
  data = YAML::parse( File.open(File.expand_path(data_file)))

  columns = []
  data.value.first.value.each do |v|
    columns << v.value.to_s
  end
  
  rows = []
  data.value[1..data.value.count].each do |row|
    current = []
    row.value.each do |el|
      current << el.value
    end
    rows << current
  end

  return [columns, rows]
end

