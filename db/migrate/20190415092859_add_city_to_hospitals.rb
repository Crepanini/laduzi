class AddCityToHospitals < ActiveRecord::Migration[5.2]
  def change
    add_column :hospitals, :city, :string
  end
end
