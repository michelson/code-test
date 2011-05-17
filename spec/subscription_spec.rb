require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../subscriptions.rb'

describe Subscription do
  before do
    @states = ["CA", "CO","MI", "MT", "WA", "NV"]
    @states.each do |state|
      Customer.create(:name=>Faker::Name.name , :state=>state)
      3.times do
        Dispensary.create(:name=>Faker::Name.name, :state=>state)
      end
    end
  end
  
  it "should be 6 customers" do
    Customer.count.should eql(6)
  end
  
  it "should be 18 Dispensaries" do
    Dispensary.count.should eql(18)
  end
  
end