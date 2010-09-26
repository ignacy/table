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

  private

  def get_column_contents(n)
    @rows.inject([]) { |out, row| out << row[n] }
  end

  def get_index(column)
    index = @columns.index(column)
    index.nil? ? column : index
  end

end
