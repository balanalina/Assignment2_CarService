require_relative 'request_repo'

#schedule of the car wash
module Schedule
  OPENING_TIME = 8
  CLOSING_TIME = 18
  OPENING_TIME_SATURDAY = 9
  CLOSING_TIME_SATURDAY = 15
  HOUR = 3600
  DAY = 24 * 3600
  MINUTE = 60
end

class RequestService
  include Schedule

  def initialize
    #one for each worker, 2 cars can be washed at the same time
    @schedule1 = Repo.new
    @schedule2 = Repo.new
  end

  def add_request
    new_request = Request.new
    set_pickup_date(new_request)
    pickup_date_print(new_request)
  end

  #pretty print of the time
  def pickup_date_print(request)
    request.pickup_time.strftime("%A %d-%m-%Y %H:%M")
  end

  private
  # @param [Request] request
  #computes and sets the pickup time attribute of the request
  def set_pickup_date(request)
    #check to see which worker will wash the car and set the starting time for the washing
    # check if the arrays are empty
    if @schedule1.is_empty?
      request.wash_time = request.arrive_time
      compute_pickup_date(request)
      @schedule1.add_request(request)
      return
    elsif @schedule2.is_empty?
      request.wash_time = request.arrive_time
      compute_pickup_date(request)
      @schedule2.add_request(request)
      return
    end
    #check if there is a worker that is not working when the car arrives
    if @schedule1.get_last.pickup_time < request.arrive_time
      request.wash_time = request.arrive_time
      compute_pickup_date(request)
      @schedule1.add_request(request)
      return
    end
    if @schedule2.get_last.pickup_time < request.arrive_time
      request.wash_time = request.arrive_time
      compute_pickup_date(request)
      @schedule2.add_request(request)
      return
    end
    #no worker is free, see which will be free sooner
    if @schedule1.get_last.pickup_time < @schedule2.get_last.pickup_time
      #there is a 1 minute pause between finishing to wash a car and starting to wash another one
      request.wash_time = @schedule1.get_last.pickup_time + MINUTE
      compute_pickup_date(request)
      @schedule1.add_request(request)
      return
    else
      request.wash_time = @schedule2.get_last.pickup_time + MINUTE
      compute_pickup_date(request)
      @schedule2.add_request(request)
    end
  end

  #computes the pickup time based on the washing start time
  def compute_pickup_date(request)
    pickup = request.wash_time
    pickup += (2 * HOUR)
    if pickup.saturday?
      compute_pickup_date_saturday(request, pickup)
    else
      compute_pickup_date_weekday(request, pickup)
    end
  end

  def compute_pickup_date_saturday(request, pickup)
    #finish the same day
    if pickup.hour < CLOSING_TIME_SATURDAY || pickup.hour == CLOSING_TIME_SATURDAY && pickup.min == 0
      request.pickup_time = pickup
    else
      #finish the next day on monday
      pickup += DAY
      pickup += 17 * HOUR
      request.pickup_time = pickup
    end
  end

  def compute_pickup_date_weekday(request, pickup)
    if pickup.hour < CLOSING_TIME || pickup.hour == CLOSING_TIME && pickup.min == 0
      #finish the same weekday
      request.pickup_time = pickup
    else
      #finish the next day
      if (pickup + DAY).saturday?
        #next day is saturday
        pickup += 15 * HOUR
        request.pickup_time = pickup
      else
        #next day is still a weekday
        pickup += 14 * HOUR
        request.pickup_time = pickup
      end
    end
  end

end
