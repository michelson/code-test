#http://pastebin.com/AkneRQxT
module Swipey
  class CreditCard
    
    attr_reader :first_name, :last_name, :data, :level, :card_number, :exp_date, :track2
 
    def initialize(str)
      @data = str
      get_data
    end
 
    def full_name
      "#{@first_name} #{@last_name}"
    end
   
    private
 
    def get_data
      extract_name
      extract_card_number
      extract_exp_date
      extract_track2
    end
     
    def extract_name
      begin
        @first_name = (/\/([^\^]*)/).match(@data).captures[0]
        @last_name =  (/\^([^\/]*)/).match(@data).captures[0]
      rescue
      end
    end
 
    def extract_card_number
      begin
        @card_number = (/\b(?:\d[ -]*?){13,16}\b/).match(@data)[0]
      rescue => e
        puts "error retrieving cc #{e}"
      end
    end
 
    def extract_exp_date
      begin
        exp = (/\^(\d{4})/).match(@data).captures[0]
        @exp_date = "#{exp[2..3]}#{exp[0..1]}"
      end
    end
     
    def extract_track2
      begin
        @track2 = (/;([^?]*)/).match(@data).captures[0]
      rescue
      end
    end
  end
end
