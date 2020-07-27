class Request
  @@car_count = 0

  attr_reader :arrive_time, :car_nr
  attr_accessor :pickup_time, :wash_time

  def initialize
    #time when the request was made
    @arrive_time = Time.now
    #time when the car begin to be washed
    @wash_time = nil
    @@car_count += 1
    @car_nr = @@car_count
    #time when the car is washed
    @pickup_time = nil
  end
  
  #total number of requests
  def get_total_number
    @@car_count
  end
end
