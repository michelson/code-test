require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../dob_calculations.rb'

describe Date do
  before do
    Time.zone = "Santiago"
    @dobmodule = Date
    @dob =  Date.strptime("04/06/1981", "%d/%m/%Y")
  end
  
  it "Date should respond to days_until_birthday method" do
    @dobmodule.should respond_to(:days_until_birthday)
  end
  
  context "Old script should calculate days until birthday" do
    before do
      @old_calculation = @dobmodule.old_days_until_birthday(@dob)
    end
    
    it "respond with a Fixnum" do
      @old_calculation.class.should == Fixnum
    end
    
    it "should return number of days" do
      @old_calculation.round.should == (Date.strptime("04/06/2011", "%d/%m/%Y") - Time.now.to_date).to_i
    end
    
  end
  
  context "Refactored script should calculate days until birthday" do
    before do
      @calculation = @dobmodule.days_until_birthday(@dob)
    end
    
    it "should return a hash" do
      @calculation.class.should == Hash
    end
    
    it "rounded_days_until should be Fixnum" do
      @calculation[:rounded_days_until].should == (Date.strptime("04/06/2011", "%d/%m/%Y") - Time.now.to_date).to_i
      @calculation[:rounded_days_until].class.should == Fixnum
    end
    
    it "exact_days_until should be Float" do
      #@calculation[:exact_days_until].should == 19.0643234397443
      @calculation[:exact_days_until].class.should == Float
    end

    it "next birth date should be == to exact_days_until to_date & rounded_days_until to_date" do
      @calculation[:next_birth_date].should == @calculation[:rounded_days_until].days.from_now.to_date
      @calculation[:next_birth_date].should == @calculation[:exact_days_until].days.from_now.to_date
    end

  end
    
end
