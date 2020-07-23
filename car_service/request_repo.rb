require '../car_service/request'

class Repo

  def initialize
    @requests = []
  end

  def add_request(newRequest)
    @requests.push(newRequest)
  end

  def remove_request(requestToBeRemoved)
    @requests.delete(requestToBeRemoved)
  end

  def get_all
    @requests
  end

end
