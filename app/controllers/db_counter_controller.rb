class DbCounterController < ApplicationController
  def index
    @db_counters = Array.new()
    #対象外のテーブル
    skip_tables = ["schema_info", "schema_migrations", "sessions"]
	#対象テーブルの特定（カウント対象外のテーブルを除く）
	table_names = (ActiveRecord::Base.connection.tables - skip_tables)

	_TableName = Array.new()
	_Rows = Array.new()
	_Rows << ''
	
	table_names.each do |table_name, i|	 
      rows = ActiveRecord::Base.connection.execute("SELECT count(*) FROM #{table_name}")
	  
	  aDBCounter = DbCounter.new(TableName: table_name, NumberOfRows: rows[0].fetch('count(*)'))
	  @db_counters << aDBCounter
	  
	  # data for google Bar Chart
	  _TableName << aDBCounter.TableName
	  _Rows += aDBCounter.asBarChartRows
	end
		
	gon.table_name = _TableName
	gon.rows = _Rows

  end

  def show
  end
end
