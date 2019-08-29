class AddFieldsToInvestorProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :investor_profiles, :administrative_management_rate, :float, null: false, default: 0
  end
end
