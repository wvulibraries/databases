# Admin Link Tracking Controller
class Admin::LinkTrackingController < AdminController
  # Rendering an index form for link tracking
  # @author Tracy A. McCormick

  # GET /admin/link_tracking
  # GET /admin/link_tracking.json  
  def index
    @databases = if params[:start_date].present? && params[:end_date]
                   Database.all
                           .joins(:link_tracking)
                           .where( 'link_trackings.created_at > ? AND link_trackings.created_at < ?', 
                            params[:start_date], 
                            params[:end_date] )
                 else
                   Database.all
                 end

    render :index    
  end

  private  
    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_link_tracking_params
      params.require(:database).permit(:start_date, :end_date)
    end
end
