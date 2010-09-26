class Table

  attr_accessor :rows, :columns
  
  def initialize(data=nil)
    if data.nil?
      @rows = []
    else
      @rows = data if data.all? { |row| row.is_a? Array }
    end
    @columns = []
  end

  def <<(row)
    @rows << row
  end

  def [](column)
    get_column_contents(get_index(column))
  end

  def cell(row, column)
    get_column_contents(get_index(column))[row]
  end

  def select_rows(&block)
    new_rows = []
    @rows.each do |row|
      new_rows << row if block.call(row)
    end
    return new_rows
  end

  def select_columns(&block)
    filtered = []
    all_columns.each do |column|
      column = column.delete_if { |el| el.nil? }
      filtered << column if block.call(column)
    end
    return filtered
  end

  def all_columns
    columns = []
    (0..longest_row - 1).to_a.each do |i|
      @rows.each do |row|
        columns[i] = [] if columns[i].nil?
        columns[i] << row[i]
      end
    end
    return columns
  end

  def insert(index, row)
    @rows.insert(index, row)
  end

  def delete_at(index)
    @rows.delete_at(index)
  end

  def rename_column(old, new)
    index = get_index(old)
    unless index.nil?
      @columns[index] = new
    end
  end

  def insert_column(at, data)
    fill_missing_rows_and_columns(data)
    @rows.each_with_index do |row, index|
      row.insert(at, data[index]) unless data[index].nil?
    end
  end

  def delete_column(column)
    index = get_index(column)
    @rows.each { |row| row.delete_at(index) }
    @columns.delete_at(index)
  end

  def transform_column(column, &block)
    index = get_index(column)
    @rows.each { |row| row[index] = block.call(row[index])  }
  end


  private

  def fill_missing_rows_and_columns(data)
    rows = data.length
    diff = @rows.count - rows
    if diff < 0
      diff.abs.times { @rows << [] }
    end
  end

  def get_column_contents(n)
    n.nil? ? nil : @rows.inject([]) { |out, row| out << row[n] }
  end

  def get_index(column)
    index = @columns.index(column)
    if index.nil?
      if column.is_a? Integer
        column
      else
        nil
      end
    else
      index
    end
  end

  def longest_row
    longest = 0
    @rows.each do |row|
      longest = row.length if row.length > longest
    end
    return longest    
  end
end
