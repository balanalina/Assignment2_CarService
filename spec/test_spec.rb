require_relative "../car_service/request_service"

describe 'test for one car, no waiting/scheduling' do
  context 'leave it today, take it today' do
    it 'should print Thursday 23-07-2020 17:30' do
      service = RequestService.new
      allow(Time).to receive(:now).and_return(Time.new(2020,07,23,15,30))
      expect(service.add_request).to eq 'Thursday 23-07-2020 17:30'
    end
  end
  context "leave it during the week, take it the next week day "do
    it 'should print Friday 24-07-2020 09:30' do
      service = RequestService.new
      allow(Time).to receive(:now).and_return(Time.new(2020,07,23,17,30))
      expect(service.add_request).to eq 'Friday 24-07-2020 09:30'
    end
  end
  context "leave it on friday, take it on saturday" do
    it 'should print Saturday 25-07-2020 10:30' do
      service = RequestService.new
      allow(Time).to receive(:now).and_return(Time.new(2020,07,24,17,30))
      expect(service.add_request).to eq 'Saturday 25-07-2020 10:30'
    end
  end
  context "leave it on saturday, take it on saturday" do
    it 'should print Saturday 25-07-2020 12:30' do
      service = RequestService.new
      allow(Time).to receive(:now).and_return(Time.new(2020,07,25,10,30))
      expect(service.add_request).to eq 'Saturday 25-07-2020 12:30'
    end
  end
  context "leave it on saturday, take it on monday" do
    it 'should print Monday 27-07-2020 09:20' do
      service = RequestService.new
      allow(Time).to receive(:now).and_return(Time.new(2020,07,25,14,20))
      expect(service.add_request).to eq 'Monday 27-07-2020 09:20'
    end
  end
end

describe "test for more than one car" do
  context "8 cars come at the same time" do
    it 'for the 8 th car it should print Monday 27-07-2020 15:23' do
      service = RequestService.new
      allow(Time).to receive(:now).and_return(Time.new(2020, 07, 25, 14, 20))
      expect(service.add_request).to eq 'Monday 27-07-2020 09:20'
      expect(service.add_request).to eq 'Monday 27-07-2020 09:20'
      expect(service.add_request).to eq 'Monday 27-07-2020 11:21'
      expect(service.add_request).to eq 'Monday 27-07-2020 11:21'
      expect(service.add_request).to eq 'Monday 27-07-2020 13:22'
      expect(service.add_request).to eq 'Monday 27-07-2020 13:22'
      expect(service.add_request).to eq 'Monday 27-07-2020 15:23'
      expect(service.add_request).to eq 'Monday 27-07-2020 15:23'
    end
  end
  context "9 cars come 1 hour and a half apart" do
    it 'for the 5th car should print Tuesday 28-07-2020 13:30, for the 8th Tuesday 28-07-2020 18:00 car and for the 9th Wednesday 29-07-2020 09:30' do
      service = RequestService.new
      allow(Time).to receive(:now).and_return(Time.new(2020, 07, 27, 15, 30))
      expect(service.add_request).to eq 'Monday 27-07-2020 17:30'
      allow(Time).to receive(:now).and_return(Time.new(2020, 07, 27, 17))
      expect(service.add_request).to eq 'Tuesday 28-07-2020 09:00'
      allow(Time).to receive(:now).and_return(Time.new(2020, 07, 28, 8, 30))
      expect(service.add_request).to eq 'Tuesday 28-07-2020 10:30'
      allow(Time).to receive(:now).and_return(Time.new(2020, 07, 28, 10))
      expect(service.add_request).to eq 'Tuesday 28-07-2020 12:00'
      allow(Time).to receive(:now).and_return(Time.new(2020, 07, 28, 11, 30))
      expect(service.add_request).to eq 'Tuesday 28-07-2020 13:30'
      allow(Time).to receive(:now).and_return(Time.new(2020, 07, 28, 13))
      expect(service.add_request).to eq 'Tuesday 28-07-2020 15:00'
      allow(Time).to receive(:now).and_return(Time.new(2020, 07, 28, 14, 30))
      expect(service.add_request).to eq 'Tuesday 28-07-2020 16:30'
      allow(Time).to receive(:now).and_return(Time.new(2020, 07, 28, 16))
      expect(service.add_request).to eq 'Tuesday 28-07-2020 18:00'
      allow(Time).to receive(:now).and_return(Time.new(2020, 07, 28, 17, 30))
      expect(service.add_request).to eq 'Wednesday 29-07-2020 09:30'
    end
  end
end