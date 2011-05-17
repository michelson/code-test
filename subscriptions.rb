require "rubygems"
require "bundler/setup"
require 'data_mapper'
#DataMapper.setup(:default, 'sqlite://project.db')
DataMapper.setup(:default, 'sqlite::memory:')



class Subscription
  include DataMapper::Resource

  property :id,         Serial    
  property :name,       String    
  property :status,     Boolean, :default  => false
  property :created_at, DateTime  
  
  belongs_to :dispensary
  #has n, :customers, :through => :dispensaries

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
end


class Customer
  include DataMapper::Resource
  property :id,            Serial 
  property :name,          String   
  property :dispensary_id, Integer   
  property :state,         String    
  belongs_to :dispensary
end

class Dispensary
  include DataMapper::Resource
  property :id,         Serial  
  property :name,       String
  property :state,      String    
  has n, :customers
end

DataMapper.finalize
DataMapper.auto_migrate!

