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
  
  private

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
