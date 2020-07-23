require '../car_service/request_repo'
require 'Date'

module DateCalcInSec
  HOUR = 3600
  DAY = 24 * 3600
end

module Schedule
  OPENING_TIME = 8
  CLOSING_TIME = 18
  OPENING_TIME_WEEKEND = 9
  CLOSING_TIME_WEEKEND = 15

end


class RequestService
  include Schedule
  include DateCalcInSec

  def initialize
    @schedule1 = Repo.new
    @schedule2 = Repo.new
  end

  def add_request(time  = Time.now)
    newRequest = Request.new time
    return_pickup_date newRequest
  end

  private
  def return_pickup_date(request)
    if @schedule1.is_empty?
      request.pickupTime = request.arriveTime
      compute_pickup_date request
      @schedule1.add_request request
    end
  end

  def compute_pickup_date(request)
    include Schedule
    include DateCalcInSec

    pickup = request.arriveTime
    pickup += (2 * HOUR)

    if pickup.saturday?
      if pickup.hour < CLOSING_TIME_WEEKEND || pickup.hour == CLOSING_TIME_WEEKEND && pickup.min == 0
        request.pickupTime = pickup
      else
        pickup += DAY
        pickup += 17 * HOUR
        request.pickupTime = pickup
      end
    else
      if pickup.hour < CLOSING_TIME || pickup.hour == CLOSING_TIME && pickup.min == 0
        request.pickupTime = pickup
      else
        if (pickup + DAY).saturday?
          pickup += 15 * HOUR
          request.pickupTime = pickup
        else
          pickup += 14 * HOUR
          request.pickupTime = pickup
        end
      end
    end
  end

end
