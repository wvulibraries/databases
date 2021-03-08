# Admin Link Tracking Controller
class Admin::LinkTrackingController < AdminController
  before_action :set_dates , only: [:index]

  # Rendering an index form for link tracking
  # @author Tracy A. McCormick

  # GET /admin/link_tracking
  # GET /admin/link_tracking.csv
  def index
    @databases = Database.all
          .joins(:link_tracking)
          .where( 'link_trackings.created_at > ? AND link_trackings.created_at < ?', 
          @start, 
          @end )
          .distinct
    respond_to do |format|
      format.html do
        render :index 
      end
      format.csv do
        send_data @databases.linktracking_export, filename: "linktracking-#{Date.today}.csv"
      end
    end
  end  

  private
    # set start and end dates for the filter
    # verify start_date and end_date is in proper 
    # format from passed params.
    # @author Tracy A. McCormick    
    def set_dates
      if check_date_format(params[:start_date].to_s) && check_date_format(params[:end_date].to_s)
        @start = params[:start_date]
        @end = params[:end_date]
      else
        @start = Date.today - 1.month
        @end = Date.today
      end  
    end

    # verify date string is valid
    # @author Tracy A. McCormick
    # @return Boolean  
    def check_date_format(dt)
      begin
        Date.parse(dt)
        true
      rescue ArgumentError
        false
      end
    end    
end
