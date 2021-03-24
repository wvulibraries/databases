# Admin Link Tracking Controller
class Admin::LinkTrackingController < AdminController
  before_action :set_dates , only: [:index]
    
  # Rendering an index form for link tracking
  # @author Tracy A. McCormick

  # GET /admin/link_tracking
  def index
    stats = Statistics::Base.new({start_date: params[:start_date], end_date: params[:end_date]})
    begin
      @databases = stats.perform_query
      render :index
    rescue StandardError => error
      redirect_to admin_link_tracking_index_url, error: error
    end
  end
  
  private
    # set start and end dates for the filter
    # verify start_date and end_date is in proper 
    # format from passed params.
    # @author Tracy A. McCormick    
    def set_dates
      if params[:start_date] && params[:end_date]
        @start = params[:start_date]
        @end = params[:end_date]
      else
        @start = Date.today - 1.month
        @end = Date.today
      end  
    end  

end
