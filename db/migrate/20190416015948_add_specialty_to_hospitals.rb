class AddSpecialtyToHospitals < ActiveRecord::Migration[5.2]
  def change
    add_column :hospitals, :specialty, :string
  end
end
