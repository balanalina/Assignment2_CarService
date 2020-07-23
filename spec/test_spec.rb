require './car_service/request'
require 'Date'

describe "model tests" do
  context "check car numbers" do
    req1 = Request.new(Time.now,Date.today)
    req2 = Request.new(Time.now,Date.today)
    it 'should be 2' do
      expect(req2.get_total_number).to eq 2
    end
    it 'should be 1' do
      expect(req1.carNr).to eq 1
    end
  end

end