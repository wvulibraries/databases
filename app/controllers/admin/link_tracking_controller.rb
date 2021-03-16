# Admin Link Tracking Controller
class Admin::LinkTrackingController < AdminController
  # Rendering an index form for link tracking
  # @author Tracy A. McCormick

  # GET /admin/link_tracking
  def index
    stats = Statistics::Base.new({start_date: params[:start_date], end_date: params[:end_date]})

    begin
      @databases = stats.perform_query
      render :index
    rescue StandardError => error
      redirect_to admin_link_tracking_index_url, flash: { error: error }
    end
  end  
end
