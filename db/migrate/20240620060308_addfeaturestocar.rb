class Addfeaturestocar < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :features, :string, array: true, default: []
  end
end
