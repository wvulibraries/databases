# Public::AboutController 
# this controller will be for landing pages. 
class Public::AboutController < ApplicationController
  # Gets the uuid and fetches the database to format the landing page.
  # @author David J. Davis
  def index 
    # set database
    @database = Database.where(url_uuid: params[:uuid]).first
    @landing_page = @database.landing_page
    render :index
  end
end 