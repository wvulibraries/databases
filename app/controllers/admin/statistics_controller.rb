# Admin Statistics Controller
class Admin::StatisticsController < AdminController
    # /admin/stats
    def show_all
      # query that shows all database and their joins for link_tracking
      @databases = Database.all
        .joins(:link_tracking)
        .distinct
        .order(:name)
      send_data @databases.linktracking_export, filename: "database-usage-full-#{Date.today}.csv"
    end 

    # /admin/stats/:start_date/:end_date/
    def show
      stats = Statistics::CSV.new(params.slice(:start_date, :end_date))
      begin
        send_data stats.as_csv, filename: "database-usage-#{params[:start_date]}-#{params[:end_date]}.csv", disposition: 'inline'
      rescue StandardError => error
        redirect_to admin_link_tracking_index_url, error: error
      end
    end  

end