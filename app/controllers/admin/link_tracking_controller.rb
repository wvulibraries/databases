# Admin Link Tracking Controller
class Admin::LinkTrackingController < AdminController
  # Rendering an index form for link tracking
  # @author David J. Davis
  def index
    @databases = Database.all
    render :index
  end


end
