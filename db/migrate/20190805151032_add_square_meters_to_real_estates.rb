class AddSquareMetersToRealEstates < ActiveRecord::Migration[5.2]
  def change
    add_column :real_estates, :square_meters, :float, default: 0
  end
end
