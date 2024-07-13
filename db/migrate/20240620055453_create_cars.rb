# db/migrate/TIMESTAMP_create_cars.rb
class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string :name_en
      t.string :name_ar
      t.integer :seats_num
      t.integer :make_year
      t.float :engine_size
      t.string :transmission_ar
      t.string :transmission_en
      t.integer :cylinders
      t.string :fuel_type_en
      t.string :fuel_type_ar
      t.integer :doors
      t.string :colors
      t.string :car_type_ar
      t.string :car_type_en

      t.timestamps
    end
  end
end
