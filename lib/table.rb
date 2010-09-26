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

end
