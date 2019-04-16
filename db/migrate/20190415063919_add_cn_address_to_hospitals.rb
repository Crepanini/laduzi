class AddCnAddressToHospitals < ActiveRecord::Migration[5.2]
  def change
    add_column :hospitals, :cn_address, :string
  end
end
