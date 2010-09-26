require File.dirname(__FILE__) + '/../lib/table'

describe Table do
  context "create new object" do
    it "initialize with a two dimensional array" do
      @table = Table.new [[1, 2, 3], [4, 5, 6, 7], ["something"]]
      @table.should be_a Table
      @table.rows.count.should eql(3)
    end

    it "should be possible to create a new table and then append rows" do
      @table = Table.new
      @table.rows.count.should eql(0)
      @table << [1, 2]
      @table << ["second", "row"]
      @table.rows.count.should eql(2)
    end
  end

  context "columns" do
    before(:each) do
      @table = Table.new [[1, 2, 3], [4, 5, 6, 7], ["something"]]
    end

    it "should be possible to set and access column by names" do
      @table.columns = ["Lp.", "Number1", "Column3"]
      @table["Lp."].should == [1, 4, "something"]
    end
    
    it "should be possible to set and access column by names (no data in some rows)" do
      @table.columns = ["Lp.", "Number1", "Column3"]
      @table["Column3"].should == [3, 6, nil]
    end

    it "should be possible to access columns by index" do
      @table.columns = ["Lp.", "Number1", "Column3"]
      @table[0].should == [1, 4, "something"]
    end

    it "should be possible to access columns by index when not set" do
      @table[0].should == [1, 4, "something"]
    end
  end

  context "cells" do
    it "should be possible to access cell by (row, column) when column is int" do
      @table = Table.new [[1, 2, 3], [4, 5, 6, 7], ["something"]]
      @table.columns = ["Lp.", "Number1", "Column3"]
      @table.cell(0, 2).should == 3
    end

    it "should be possible to access cell by (row, column) when column is column name" do
      @table = Table.new [[1, 2, 3], [4, 5, 6, 7], ["something"]]
      @table.columns = ["Col1", "Col2", "Col3"]
      @table.cell(1, "Col2").should == 5
    end
  end

  context "possible row manipulations" do
    before :each do
      @table = Table.new [[1, 2, 4], [10, "kret", 21], ["car", "cdr"]]
      @table.columns = ["Numbers", "Something with kret", "CarAndCdr"]
    end

    it "should be possible to get row data" do
      @table.rows[1].should == [10, "kret", 21]
    end

    it "should be possible to append a row to the end of a table" do
      @table << [10, 21]
      @table.rows.count.should eql(4)
      @table.rows.last.should == [10, 21]
    end

    it "should be possible to insert a row at a position" do
      @table.insert(1, [10, 20, 30])
      @table.rows[1].should == [10, 20, 30]
    end

    it "should be possible to delete any row" do
      @table.delete_at(1)
      @table.rows.count.should eql(2)
      @table.rows[1].should == ["car", "cdr"]
    end

    it "should transform blocks like Enumerable#map" do
      @table.rows[1] = @table.rows[1].map { |x| x*2 }
      @table.rows[1].should == [20, "kretkret", 42]      
    end
  end

  context "possible column manipulations" do
     before :each do
      @table = Table.new [[1, 2, 4], [10, "kret", 21], ["car", "cdr"]]
      @table.columns = ["Numbers", "Something with kret", "CarAndCdr"]
    end

    it "retrive column array" do
      @table["Numbers"].should == [1, 10, "car"]
    end

    it "should rename a column" do
      @table.rename_column("Numbers", "NotOnlyNumbers")
      @table["NotOnlyNumbers"].should == [1, 10, "car"]
      @table["Numbers"].should be_nil
    end

    it "should add a column to the right side" do
      @table.insert_column(3, [1, 2, 3, 4, 5])
      @table.rows.count.should eql(5)
      @table.rows[2].should == ["car", "cdr", nil, 3]
      @table.rows[3].should == [nil, nil, nil, 4]
      @table.rows[4].should == [nil, nil, nil, 5]
    end

    it "should insert a column at any position" do
      @table.insert_column(1, [1, 2])
      @table.rows[0].should == [1, 1, 2, 4]
      @table.rows[1].should == [10, 2, "kret", 21]
      @table.rows[2].should == ["car", "cdr"]
    end

    it "should delete any column" do
      @table.delete_column(1)
      @table.columns.count.should eql(2)
      @table.rows[0].should == [1, 4]
    end

    it "should allow map on columns contents" do
      @table.transform_column("Numbers") { |n| n.to_s }
      @table["Numbers"][0].should == "1"
      @table["Numbers"][1].should be_a String
      @table["Numbers"][2].should == "car"
    end
  end
end
