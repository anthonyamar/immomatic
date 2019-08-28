class CreateInvestorProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :investor_profiles do |t|
      t.float :credit_years, default: 25
      t.float :credit_rate, default: 1.6
      t.float :credit_insurance, default: 60
      t.integer :number_of_investors, default: 1
      t.string :legal_form, default: "sci_is"
      t.float :net_yield_limit, default: 1
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
