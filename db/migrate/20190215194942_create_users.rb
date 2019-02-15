class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name 
      t.string :last_name 
      t.string :cas_email 
      t.string :cas_username  
      t.timestamps
    end
  end
end
