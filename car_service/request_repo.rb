require_relative 'request'

class Repo

  attr_reader :requests

  def initialize
    @requests = []
  end

  def add_request(new_request)
    @requests.push(new_request)
  end

  def remove_request(request_to_be_removed)
    @requests.delete(request_to_be_removed)
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
