class DbCounter
  include ActiveAttr::Model

  attribute :TableName
  attribute :NumberOfRows
 
  def asBarChartRows
    anArray = Array.new()
	anArray.push(self.NumberOfRows.to_i)
    return anArray
  end

end