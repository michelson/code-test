require "rubygems"
require "bundler/setup"
require 'data_mapper'
DataMapper.setup(:default, 'sqlite::memory:')
 
class State
  include DataMapper::Resource
  property :id,         Serial  
  property :name,       String
    
  has n, :dispensaries
  has n, :customers
  
  def self.get_all
    all #(:foo=>bar)
  end
  
end

class Subscription
  include DataMapper::Resource

  property :id,            Serial    
  property :name,          String    
  property :status,        String, :default  => "disabled"
  property :customer_id,   Integer
  property :created_at,    DateTime  
  
  belongs_to :dispensary
  belongs_to :customer
  
  def self.actives
    Subscription.all(:status => :active)
  end

end

class Customer
  include DataMapper::Resource
  property :id,            Serial 
  property :name,          String   
  property :dispensary_id, Integer   
  property :state_id,      Integer    
  
  has n, :subscriptions
  belongs_to :state
  belongs_to :dispensary
  
end

class Dispensary
  include DataMapper::Resource
  property :id,         Serial  
  property :name,       String
  property :state_id,   Integer    
  
  has n, :customers
  #has n, :dispensaries, :through => :customers
  belongs_to :state
  
end

def active
  counter = { :dispensaries=>[], :customers=>[] }
  State.all.map do |state|
    counter[:dispensaries] << [state.name, state.dispensaries.count]
    s = Subscription.all(Subscription.customer.state.name=>state.name).actives
    counter[:customers] << [state.name, s.count]
  end
  return counter
end

DataMapper.finalize
DataMapper.auto_migrate!