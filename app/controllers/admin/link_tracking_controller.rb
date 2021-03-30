# Admin Link Tracking Controller
class Admin::LinkTrackingController < AdminController
  before_action :start, :end, only: [:index]
    
  # Rendering an index form for link tracking
  # @author Tracy A. McCormick

  # GET /admin/link_tracking
  def index
    stats = Statistics::Base.new(params.slice(:start_date, :end_date))
    begin
      @databases = stats.perform_query
      render :index
    rescue StandardError => error
      redirect_to admin_link_tracking_index_url, error: error
    end
  end
  
  private
  
    def start 
      @start = (params[:start_date] || Date.today.prev_month)
    end 

    def end 
      @end = (params[:end_date] || Date.today)
    end     

end
