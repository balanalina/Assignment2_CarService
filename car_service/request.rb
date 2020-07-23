class Request
  @@carCount = 0

  attr_reader :arriveTime, :arriveDate, :carNr
  attr_accessor :pickDate, :pickTime

  def initialize(arriveTime,arriveDate)
    @arriveTime = arriveTime
    @arriveDate = arriveDate
    @@carCount += 1
    @carNr = @@carCount
    @pickDate = nil
    @pickTime = nil
  end

  def get_total_number
    @@carCount
  end

end
