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

  context "possible manipulations" do
    before :each do
      @table = Table.new [[1, 2, 4], [10, "kret", 21], ["car", "cdr"]]
      @table.columns = ["Numbers", "Something with kret", "CarAndCdr"]
    end


  end
end
