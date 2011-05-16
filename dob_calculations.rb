require "rubygems"
require "bundler/setup"
require "active_support/core_ext"

class Date
  
  def self.days_until_birthday(dob)
    now = Time.zone.now
    next_birth_year = dob.month < now.month ? 1.year.from_now.year : now.year
    next_birth_date = Time.zone.local( next_birth_year, dob.month, dob.day )
    days_until = (next_birth_date - now)/1.day
    days_until.abs == days_until ? days_until : 1.year - days_until
    {
      :exact_days_until=> days_until, 
      :next_birth_date=> days_until.days.from_now.to_date,
      :rounded_days_until=> days_until.ceil
    }
  end
  
  # script from http://pastebin.com/N2dDB8Ee
  def self.old_days_until_birthday(dob)
    now = Time.mktime(Time.now.year, Time.now.month, Time.now.day)
    temp_dob = Time.mktime((dob.month < now.month ? 1.year.from_now.year : now.year), dob.month, dob.day)
    days_until = (temp_dob-now).to_i/86400
    if (days_until.abs == days_until)
      days_until
    else
      365-days_until
    end
  end
  
end