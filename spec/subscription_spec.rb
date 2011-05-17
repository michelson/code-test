require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../subscriptions.rb'



describe Subscription do
  before(:each) do
    reset_db
    states = ["CA", "CO","MI", "MT", "WA", "NV"]
    states.each do |s|
      State.create(:name=>s)
    end
    @states = State.all
    @states.each do |state|
      state.dispensaries.create(:name=>Faker::Name.name)
    end
    @states.each do |state|
      d = Dispensary.first(:state_id=>state.id)
      state.customers.create(:name=>Faker::Name.name, :dispensary_id=>d.id)
    end
    Customer.first.subscriptions.create(:status=>:active, :dispensary_id=>Dispensary.first.id)
  end
  
  after do
    Customer.all.destroy
    Dispensary.all.destroy
    Subscription.all.destroy
    State.all.destroy
  end
  
  it "should be 6 states" do
    State.count.should eql(6)
  end
  
  it "should be 18 customers" do
    Customer.count.should eql(6)
  end
  
  it "should be 18 Dispensaries" do
    Dispensary.count.should eql(6)
  end
  
  it "should be one active subscription" do
    Subscription.actives.count.should eql(1)
  end
  
  it "display dispensaries by state" do
   counter = []
   State.all.map do |state|
     counter << [state.name, state.dispensaries.count]
     state.dispensaries.count.should eq(1)
   end
    counter.should_not be_empty
  end
  
  it "display active subscriptions by customer" do
    counter = []
    State.all.map do |state|
      s = Subscription.all(Subscription.customer.state.name=>state.name).actives
      counter << [state.name, s.count]
      if state.name == "CA"
        s.count.should eq(1)
      else
        s.count.should eq(0)
      end
    end
    counter.should_not be_empty
  end
   
  it "display active" do
   collections = active
   collections[:dispensaries].should_not be_empty
   collections[:customers].should_not be_empty
   puts collections.to_yaml
  end
  
end