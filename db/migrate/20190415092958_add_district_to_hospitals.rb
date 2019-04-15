class AddDistrictToHospitals < ActiveRecord::Migration[5.2]
  def change
    add_column :hospitals, :district, :string
  end
end
