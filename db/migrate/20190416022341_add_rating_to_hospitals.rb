class AddRatingToHospitals < ActiveRecord::Migration[5.2]
  def change
    add_column :hospitals, :rating, :float
  end
end
