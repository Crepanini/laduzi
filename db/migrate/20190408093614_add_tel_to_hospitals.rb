class AddTelToHospitals < ActiveRecord::Migration[5.2]
  def change
    add_column :hospitals, :tel, :string
  end
end
