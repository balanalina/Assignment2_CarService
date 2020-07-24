require_relative "../car_service/request_service"
# require_relative "../car_service/request_repo"
# require_relative "../car_service/request"

describe 'test for one car, no waiting/scheduling' do
  context 'leave it today, take it today' do
    it 'should print Thursday 23-07-2020 17:30' do
      service = RequestService.new
      allow(Time).to receive(:now).and_return(Time.new(2020,07,23,15,30))
      expect(1+1).to eq 2
      expect(service.add_request).to eq 'Thursday 23-07-2020 17:30'
    end
  end
end