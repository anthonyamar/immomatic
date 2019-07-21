class CreateRealEstates < ActiveRecord::Migration[5.2]
  def change
    create_table :real_estates do |t|
			t.string :ad_link
			t.float  :buying_price, null: false
			t.float  :monthly_rent_estimation, null: false
			t.float  :annual_charges, null: false
			t.float  :works_budget, default: 0
			t.float  :furniture_budget, default: 0
			t.float  :others_budget, default: 0
			t.float  :net_yield
			t.float  :annual_cashflow
			t.string :state, null: false
			t.string :address_street
			t.string :postal_code
			t.string :city
			t.string :country
			
			t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
