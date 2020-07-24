require_relative 'request'

class Repo

  def initialize
    @requests = []
  end

  #add a new request
  def add_request(new_request)
    @requests.push(new_request)
  end

  #remove a request
  def remove_request(request_to_be_removed)
    @requests.delete(request_to_be_removed)
  end

  #get all requests
  def get_all
    @requests
  end

  #get the first ddded request
  def get_first
    @requests.first
  end

  #get the last added request
  def get_last
    @requests.last
  end

  #get the total number of requests
  def get_size
    @requests.size
  end

  #check if there are requests
  def is_empty?
    @requests.empty?
  end

end
