class Public::AboutController < ApplicationController
  def index 
    # set database
    @database = Database.where(url_uuid: params[:uuid]).first
    render :index
  end
end 