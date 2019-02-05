# Database Decorator
class DatabaseDecorator < SimpleDelegator
  # Checks attributes title/popular to format title
  # @author David J. Davis
  # @return csv object
  def display_title
    if popular || trial_database
      "<h3 class='popular-title'> #{name} </h3>".html_safe
    else
      "<h3> #{name} </h3>".html_safe
    end 
  end 

  # Checks to see if the database has a landing page.
  # This will determine logic for the database linking.  
  # @author David J. Davis
  # @return boolean
  def landing_page? 
    landing_page.present? 
  end
  
  # Checks to see if the database has a landing page.
  # This will determine logic for the database linking.  
  # @author David J. Davis
  # @return boolean
  def link_to_landing_page 
    "/#{url_uuid}"
  end
  
end  
