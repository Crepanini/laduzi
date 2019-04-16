class AddRatingsToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :service_rating, :float
    add_column :comments, :environment_rating, :float
    add_column :comments, :doctor_rating, :float
    add_column :comments, :price_rating, :float
    add_column :comments, :avg_rating, :float

  end
end
