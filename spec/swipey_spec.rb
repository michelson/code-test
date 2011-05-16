require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../swipey.rb'

describe Swipey::CreditCard do
  before do
    @visa_card = "%B4788250000028291^CARD/PAYMENTECH TEST^14051015432112345601?;4788250000028291=14051015432112345601?"
    @swipe = Swipey::CreditCard.new(@visa_card)
  end
  
  it "should return first name, last name, card number, exp_date and track2 data from a VISA card" do
    @swipe.first_name.should eql('PAYMENTECH TEST')
    @swipe.last_name.should eql('CARD')
    @swipe.card_number.should eql('4788250000028291')
    @swipe.exp_date.should eql('0514')
    @swipe.track2.should eql('4788250000028291=14051015432112345601')
  end
  
  
  context "errors" do
    before do
      @visa_card = "%B4788250000028291^CARD/PAYMENTECH TEST^14051015432112345601?;4788250000028291456=14051015432112345601?"
      @swipe = Swipey::CreditCard.new(@card_with_errors)
      puts @swipe.to_yaml
    end
    
    it "card should be nil" do
      #@swipe.first_name.should eql('PAYMENTECH TEST')
      #@swipe.last_name.should eql('CARD')
      @swipe.card_number.should be_nil
      #@swipe.exp_date.should eql('0514')
      #@swipe.track2.should eql('4788250000028291=14051015432112345601')
    end
  end
  
  
end