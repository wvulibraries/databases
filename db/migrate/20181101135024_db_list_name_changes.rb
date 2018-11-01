class DbListNameChanges < ActiveRecord::Migration[5.2]
  def change
    rename_table :dbList, :database_list
    #change_table(:database_list) { |t| t.timestamps }
    rename_column :database_list, :ID, :id
    rename_column :database_list, :yearsOfCoverage, :years_of_coverage
    rename_column :database_list, :offCampusURL, :off_campus_url
    rename_column :database_list, :accessType, :access_type
    rename_column :database_list, :fullTextDB, :full_text_db
    rename_column :database_list, :newDatabase, :new_database
    rename_column :database_list, :trialDatabase, :trial_database
    rename_column :database_list, :helpURL, :help_url
    rename_column :database_list, :createDate, :created_date
    rename_column :database_list, :updateDate, :updated_date
    rename_column :database_list, :URLID, :url_id
    rename_column :database_list, :trialExpireDate, :trial_expire_date
    rename_column :database_list, :titleSearch, :title_search
  end
end
