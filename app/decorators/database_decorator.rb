# Database Decorator
class DatabaseDecorator < SimpleDelegator
  # Checks attributes title/popular to format title
  # @author David J. Davis
  # @return [String] h3 with nested link
  def display_title
    link = title_link
    if popular || trial_database || new_database
      "<h3 class='popular-title'> #{link} </h3>".html_safe
    elsif open_access 
      "<h3 class='open-title'> #{link} </h3>".html_safe
    else
      "<h3> #{link} </h3>".html_safe
    end 
  end 

  # Creates a link to return to the display_title 
  # @author David J. Davis
  # @return [String] link
  def title_link
    if landing_page?
      "<a href='#{link_to_landing_page}'> #{name} </a>"
    else
      "<a href='#{link_to_database}'> #{name} </a>"
    end 
  end 

  # Checks to see if the database has a landing page.
  # This will determine logic for the database linking.  
  # @author David J. Davis
  # @return [Boolean]
  def landing_page? 
    landing_page.present? 
  end
  
  # Checks to see if the database has a landing page.
  # This will determine logic for the database linking.  
  # @author David J. Davis
  # @return [String] url
  def link_to_landing_page 
    "/about/#{url_uuid}"
  end

  # Forwards user to the proper database page based on the 
  # @author David J. Davis
  # @return [String] url
  def link_to_database 
    "/connect/#{url_uuid}"
  end
  
end  
