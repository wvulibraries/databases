# This import service is to import a CSV into the rails application.
# @author David J. Davis
# @description It will take a CSV and update all possible entries in the CSV.
# New items will be added and associations will be added and modified as needed.
class DatabaseImportService
  def initialize(csv)
    @import_data = csv
  end
end