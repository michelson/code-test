def active
  @subscriptions = Subscription.all(:status => :active)
  @CA = 0
  @CO = 0
  @MI = 0
  @MT = 0
  @WA = 0
  @NV = 0

  @subscriptions.each do |s|
    if s.dispensary.state
      if s.dispensary.state == "CA"
        @CA = @CA + 1
      end
      if s.dispensary.state == "CO"
        @CO = @CO + 1
      end
      if s.dispensary.state == "MI"
        @MI = @MI + 1
      end
      if s.dispensary.state == "MT"
        @MT = @MT + 1
      end
      if s.dispensary.state == "WA"
        @WA = @WA + 1
      end
      if s.dispensary.state == "NV"
        @NV = @NV + 1
      end
    else
      @cust = Customer.all(:dispensary_id => s.dispensary.id, :state.not => nil, :limit => 1).first.state
      if @cust == "CA"
        @CA = @CA + 1
      end
      if @cust == "CO"
        @CO = @CO + 1
      end
      if @cust == "MI"
        @MI = @MI + 1
      end
      if @cust == "MT"
        @MT = @MT + 1
      end
      if @cust == "WA"
        @WA = @WA + 1
      end
      if @cust == "NV"
        @NV = @NV + 1
      end
    end
  end
  display @subscriptions
end
