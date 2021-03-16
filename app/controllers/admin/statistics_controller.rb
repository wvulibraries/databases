# Admin Statistics Controller
class Admin::StatisticsController < AdminController

    def show
      csv_data = Statistics::CSV.new({params['start_date'], params['end_date']}).as_csv 
      send_data csv_data, filename: "linktracking-#{Date.today}.csv"
    end 

end