require '../car_service/request_repo'
require 'Date'

module Schedule
  OPENING_TIME = '08:00'
  CLOSING_TIME = '18:00'
  OPENING_TIME_WEEKEND = '09:00'
  CLOSING_TIME_WEEKEND = '15:00'

  def is_working_day(day)
    return false if day.sunday?
    true
  end

end


class RequestService
  include Schedule

  def initialize
    @repo = Repo.new
    @schedule1 = []
    @schedule2 = []
  end

  def add_request
    @repo.add_request Request.new Time.now, Date.today
  end

  def compute_pickup_date
    nil
  end

end
