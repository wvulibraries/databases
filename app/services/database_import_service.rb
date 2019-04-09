# This import service is to import a CSV into the rails application.
# @author David J. Davis
# @description It will take a CSV and update all possible entries in the CSV.
# New items will be added and associations will be added and modified as needed.
class DatabaseImportService
  # def initialize(csv)
  #   @import_data = csv
  # end

  # Returns the vendor object if it can find it otherwise creates one
  # @author David J. Davis
  # @return Object
  def import(csv_file)
    ActiveRecord::Base.transaction do
      CSV.foreach(csv_file,  headers: true,  header_converters: :symbol, converters: :all) do |db|
        db_hash = db.to_h
        db_hash[:created_at] = Time.zone.now
        db_hash[:updated_at] = Time.zone.now
        db_params = db_hash.except(:vendor_name,
                                   :subjects_column,
                                   :resources_column)
        database = Database.where(id: db_hash[:id]).first_or_initialize(db_params)
        # setting associations
        database.vendor = create_vendor(db_hash[:vendor_name]) unless db_hash[:vendor_name].blank? 
        database.subject_ids = create_association_lists(db_hash[:subjects_column], Subject) unless db_hash[:subjects_column].blank? 
        database.resource_ids = create_association_lists(db_hash[:resources_column], Resource) unless db_hash[:resources_column].blank? 
        # save the database ignore validations
        database.save(validate: false)
      end
    end
    true
  rescue StandardError => e
    e.message
  end

  # Returns the vendor object if it can find it otherwise creates one
  # @author David J. Davis
  # @return Object
  def create_vendor(vendor_name)
    Vendor.find_or_create_by(name: vendor_name)
  end

  # Breaks apart lists of subjects or resources for insertion.
  # ID's are pulled into an array. 
  # The duplicates are then removed and array is returned.
  # @author David J. Davis
  # @params String, Model
  # @return Array
  def create_association_lists(list, model)
    list_arry = list.split(';')
    tmp_arry = []
    list_arry.each do |item_name|
      tmp_item = model.find_or_create_by(name: item_name)
      tmp_arry << tmp_item.id
    end
    tmp_arry.uniq
  end
end
