class CreateHospitals < ActiveRecord::Migration[5.2]
  def change
    create_table :hospitals do |t|
      t.string :image
      t.string :name
      t.string :address
      t.integer :price
      t.string :weekday
      t.string :weekend
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
