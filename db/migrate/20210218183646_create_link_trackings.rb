class CreateLinkTrackings < ActiveRecord::Migration[5.2]
  def change
    create_table :link_trackings do |t|
      t.references :database, polymorphic: true
      t.string :ip_address, limit: 15

      t.timestamps
    end
  end
end
