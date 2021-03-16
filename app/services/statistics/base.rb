# Database Statictics Service Base Class.
# @author(s) David J. Davis, Tracy A. McCormick
class Statistics::Base 
  def initialize(params = {})
    @start_date = (params[:start_date] || (Date.today - 1.month).to_s)
    @end_date = (params[:end_date] || Date.today.to_s)  
  end

  def valid_date(date) 
    date.match?(/([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/)  
  end 
  
  def valid?
    [@start_date, @end_date].map { |d| valid_date(d) }.all? # check to see if all values are true
  end 
  
  def perform_query # return array
    if self.valid? 
      # query
      return @database = Database.all
        .joins(:link_tracking)
        .where( 'link_trackings.created_at > ? AND link_trackings.created_at < ?', 
        @start_date, 
        @end_date )
        .distinct
    else 
      raise StandardError.new "Improper Dates, Date is not valid."
    end 
  end     
end 