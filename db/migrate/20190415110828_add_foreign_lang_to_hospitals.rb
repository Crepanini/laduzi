class AddForeignLangToHospitals < ActiveRecord::Migration[5.2]
  def change
    add_column :hospitals, :foreign_lang, :string
  end
end
