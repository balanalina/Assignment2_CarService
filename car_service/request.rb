require 'Date'

class Request
  @@carCount = 0

  attr_reader :arriveTime, :carNr
  attr_accessor :pickupTime

  def initialize(arriveTime)
    @arriveTime = arriveTime
    @@carCount += 1
    @carNr = @@carCount
    @pickupTime = nil
  end

  def get_total_number
    @@carCount
  end

end
