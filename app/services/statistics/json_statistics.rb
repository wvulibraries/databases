class Statistics::JSON < Statistics::Base
  def as_json 
    perform_query.to_json 
  end 
end