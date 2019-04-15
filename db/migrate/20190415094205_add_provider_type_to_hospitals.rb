class AddProviderTypeToHospitals < ActiveRecord::Migration[5.2]
  def change
    add_column :hospitals, :provider_type, :string
  end
end
