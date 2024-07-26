# Admin Link Tracking Controller
class Admin::LinkTrackingController < AdminController
  # Set Initial Start and End dates for view
  before_action :start, :end, only: [:index]
    
  # Rendering an index form for link tracking
  # @author Tracy A. McCormick

  # GET /admin/link_tracking
  def index
    stats = Statistics::Base.new(link_params)
    begin
      @databases = stats.perform_query
      render :index
    rescue StandardError => error
      redirect_to admin_link_tracking_index_url, error: error
    end
  end
  
  private
  
    def start 
      @start = (link_params[:start_date] || Date.today.prev_month)
    end 

    def end 
      @end = (link_params[:end_date] || Date.today)
    end     

    def link_params
      params.permit(:start_date, :end_date)
    end
end
