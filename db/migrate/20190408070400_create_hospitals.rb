class CreateHospitals < ActiveRecord::Migration[5.2]
  def change
    create_table :hospitals do |t|
      t.string :image
      t.string :name
      t.string :addressraill
      t.integer :price
      t.datetime :opening_time
      t.datetime :closing_time
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
