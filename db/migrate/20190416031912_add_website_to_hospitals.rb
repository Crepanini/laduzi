class AddWebsiteToHospitals < ActiveRecord::Migration[5.2]
  def change
    add_column :hospitals, :website, :string
  end
end
