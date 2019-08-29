class AddFieldsToRealEstate < ActiveRecord::Migration[5.2]
  def change
    add_column :real_estates, :others_annual_fees, :float, default: 0
    add_column :real_estates, :house_insurance, :float, default: 120
    add_column :real_estates, :property_tax, :float, default: nil
  end
end
