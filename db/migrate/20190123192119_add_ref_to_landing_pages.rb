class AddRefToLandingPages < ActiveRecord::Migration[5.2]
  def change
    add_reference :landing_pages, :database, index: true
  end
end
