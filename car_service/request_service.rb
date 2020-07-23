require '../car_service/request_repo'
require 'Date'

module TimeUtils
  HOUR = 3600
  DAY = 24 * 3600
  MINUTE = 60
end

module Schedule
  OPENING_TIME = 8
  CLOSING_TIME = 18
  OPENING_TIME_WEEKEND = 9
  CLOSING_TIME_WEEKEND = 15

end


class RequestService
  include Schedule
  include TimeUtils

  def initialize
    @schedule1 = Repo.new
    @schedule2 = Repo.new
  end

  # @param [Time] time
  def add_request(time  = Time.now)
    newRequest = Request.new time
    set_pickup_date newRequest
    pickup_date_print newRequest
  end

  def pickup_date_print(request)
    request.pickupTime.strftime("%A %d-%m-%Y %H:%M")
  end

  private
  # @param [Request] request
  def set_pickup_date(request)
    if @schedule1.is_empty?
      request.washTime = request.arriveTime
      compute_pickup_date request
      @schedule1.add_request request
      return
    elsif @schedule2.is_empty?
      request.washTime = request.arriveTime
      compute_pickup_date request
      @schedule2.add_request request
      return
    end
    if @schedule1.get_last.pickupTime < request.arriveTime
      request.washTime = request.arriveTime
      compute_pickup_date request
      @schedule1.add_request request
      return
    end
    if @schedule2.get_last.pickupTime < request.arriveTime
      request.washTime = request.arriveTime
      compute_pickup_date request
      @schedule2.add_request request
      return
    end
    if @schedule1.get_last.pickupTime < @schedule2.get_last.pickupTime
      request.washTime = @schedule1.get_last.pickupTime + MINUTE
      compute_pickup_date request
      @schedule1.add_request request
      return
    else
      request.washTime = @schedule2.get_last.pickupTime + MINUTE
      compute_pickup_date request
      @schedule2.add_request request
    end
  end

  def compute_pickup_date(request)
    pickup = request.washTime
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
