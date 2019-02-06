class Public::AboutController < ApplicationController
  def index 
    # set database
    @database = Database.where(url_uuid: params[:uuid]).first
    @landing_page = @database.landing_page
    render :index
  end
end 