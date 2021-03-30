# Database Statictics Service CSV Class.
# @author(s) David J. Davis, Tracy A. McCormick
class Statistics::CSV < Statistics::Base
  def as_csv 
    @databases = self.perform_query
    @databases.linktracking_export
  end   
end 
