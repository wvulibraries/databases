​class Statistics::CSV < Statistics::Base
  def as_csv 
    perform_query.linktracking_export
  end 
end 