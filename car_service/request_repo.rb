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

  def get_first
    @requests.first
  end

  def get_last
    @requests.last
  end

  def get_size
    @requests.size
  end

  def is_empty?
    @requests.empty?
  end

end
