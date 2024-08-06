# Database Statictics Service CSV Class.
# @author(s) David J. Davis, Tracy A. McCormick
class Statistics::Csv < Statistics::Base
  def as_csv 
    @databases = self.perform_query

    headers = %w[
      name count
    ]
    CSV.generate(headers: true) do |csv|
      csv << headers
      # get everything else
      @databases.each do |database|
        csv << database.link_tracking_csv_hash.values
      end
    end
  end   
end 
