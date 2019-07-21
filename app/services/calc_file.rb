class CalcFile

	attr_accessor :buying_price, :monthly_rent_price, :annual_charges, :monthly_charges

	def initialize(buying_price, monthly_rent_price, annual_charges, monthly_charges)
		@buying_price = buying_price
		@monthly_rent_price = monthly_rent_price
		@annual_charges = annual_charges
		@monthly_charges = monthly_charges
	end
	
	# RENTABILITY

	def gross_yield
		total_rent_revenues * total_acquisition
	end

	def net_yield
		(total_rent_revenues - total_annual_fees) * total_acquisition
	end

	def monthly_cashflow
		annual_cashflow / 12
	end

	def annual_cashflow
		total_rent_revenues - total_annual_fees
	end

	# ACQUISITION FEES

	def buying # C3
		buying_price
	end

	def notary # C4
		total = (8 * buying) / 100
		puts "notary = #{total}"
		return total
	end

	def works # C5
		0
	end

	def furniture # C6
		0
	end

	def others # C7
		2500
	end

	def total_acquisition # C8
		buying + notary + works + furniture + others
	end

	# RENT REVENUES

	def monthly_rate # C11
		monthly_rent_price + (monthly_charges / 2)
	end

	def holiday_rent # C12
		0
	end

	def total_rent_revenues # C13
		total = (monthly_rate * 12) - monthly_rate * holiday_rent
		puts "total_rent_revenues = #{total}"
		return total
	end

	# ANNUAL FEES

	def credit # C16
		# ((((C8*1%)*25)/300)+(C8/300)*0,99)*12
		
		annual_interest_rate = (total_acquisition * 1 / 100)
		lifetime_credit_interest = annual_interest_rate * 25
		monthly_credit_interest = lifetime_credit_interest / 300
		
		lifetime_credit_monthly_acquisition = total_acquisition / 300
		add_interest = lifetime_credit_monthly_acquisition * 0.99
		
		total = (monthly_credit_interest + add_interest) * 12
		
		puts "credit = #{total}"
		return total
	end

	def losing_charges # C17
		(monthly_charges / 2) * 12
	end

	def house_insurance # C18
		120
	end

	def rent_insurance # C19
		total = ((2 * monthly_rent_price) / 100) * 12
		puts "rent_insurance = #{total}"
		return total
	end

	def property_tax # C20
		monthly_rent_price * 0.7
	end

	def administrative_management # C21
		total = ((7 * monthly_rent_price) / 100) * 12
		puts "administrative_management = #{total}"
		return total
	end

	def credit_insurance # C22
		60
	end

	def various # C23
		0
	end

	def total_annual_fees # C24
		total = credit + losing_charges + house_insurance + rent_insurance + property_tax + administrative_management + credit_insurance + various
		puts "total_annual_fees = #{total}"
		return total
	end

end
