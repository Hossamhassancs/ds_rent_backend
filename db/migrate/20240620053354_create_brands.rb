class CreateBrands < ActiveRecord::Migration[7.1]
  def change
    create_table :brands do |t|
      t.string :name_ar
      t.string :name_en
      t.string :logo

      t.timestamps
    end
  end
end
