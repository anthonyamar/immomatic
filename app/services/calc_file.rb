class CalcFile

  attr_accessor :buying_price, :monthly_rent_estimation, :annual_charges, :monthly_charges,
  :works_budget, :furniture_budget, :others_budget, :investor_profile

  MONTHS = 12 # number of month in on year. 
  CREDIT_YEARS = 25 # credit duration.
  CREDIT_MONTHS_DURATION = CREDIT_YEARS * MONTHS
  CREDIT_RATE = 1.6 # average rate in the market
  TENANT_CHARGES_RATE = 1.66 # 2/3 for the tenant, 1/3 for the owner
  ADMINISTRATIVE_MANAGMENT_RATE = 0.06
  PROPERTY_TAXES = 0.7 # variable. Here set to 70% of one month_rent for the year.
  NOTARY_TAXES = 0.07 # 7% buying price. Legal statement.
  DEDUCTIBLE_CREDIT_INTEREST = 0.3 # 30% of the credit interests are deductible from the company taxes. 
  DEDUCTIBLE_DEPRECATION_RATE = 15 # 1/15 of the buying price are deductible from the company taxes


  def initialize(real_estate)
    @real_estate = real_estate
    @investor_profile = real_estate.user.investor_profile
    @buying_price = real_estate.buying_price
    @monthly_rent_estimation = real_estate.monthly_rent_estimation
    @annual_charges = real_estate.annual_charges
    @monthly_charges = real_estate.annual_charges / MONTHS
    @works_budget = real_estate.works_budget
    @furniture_budget = real_estate.furniture_budget
    @others_budget = real_estate.others_budget + 2500
  end

  # RENTABILITY

  def gross_yield
    gy = (total_rent_revenues / total_acquisition) * 100
    puts "gross_yield : #{gy}"
    gy
    # return a % usualy less than 10..15%
  end

  def net_yield
    ny = ((total_rent_revenues - total_annual_fees) / total_acquisition) * 100
    puts "net_yield : #{ny}"
    ny
    # return a % usualy less than 5..10%
  end

  def monthly_cashflow # F13
    annual_cashflow / MONTHS
    # return a currency
  end

  def annual_cashflow # F14
    total_rent_revenues - total_annual_fees
    # return a currency
  end

  def company_taxes # F16
    # Excel formula : =IF(C13-(C16*30%)-C18-C19-C20-C21-C22-(F3/15)>0;(C13-(C16*30%)-C18-C19-C20-C21-C22-(F3/15))/3;0)
    statement = total_rent_revenues - (credit * DEDUCTIBLE_CREDIT_INTEREST) - house_insurance - rent_insurance - property_tax - administrative_management - credit_insurance - (buying_price / DEDUCTIBLE_DEPRECATION_RATE)

    if statement > 0
      total = statement / 3
    else
      total = 0
    end
    puts "company_taxes : #{total}"
    total
    # return a currency
  end

  def annual_cashflow_after_taxes # F17
    annual_cashflow - company_taxes
  end

  def monthly_cashflow_after_taxes
    annual_cashflow_after_taxes / MONTHS
  end

  # ACQUISITION FEES

  def buying # C3
    buying_price
  end

  def notary # C4
    total = buying * NOTARY_TAXES
    puts "notary = #{total}"
    return total
  end

  def works # C5
    works_budget
  end

  def furniture # C6
    furniture_budget
  end

  def others # C7
    others_budget
  end

  def total_acquisition # C8
    puts "total_acquisition = #{buying + notary + works + furniture + others}"
    buying + notary + works + furniture + others
  end

  # RENT REVENUES

  def monthly_rate # C11
    mr = monthly_rent_estimation + (monthly_charges / TENANT_CHARGES_RATE)
    puts "monthly_rate : #{mr}"
    mr
  end

  def holiday_rent # C12
    0
  end

  def total_rent_revenues # C13
    total = (monthly_rate * MONTHS) - (monthly_rate * holiday_rent)
    puts "total_rent_revenues = #{total}"
    return total # return annual rent revenues
  end

  # ANNUAL FEES

  def credit # C16
    # OLD EXCEL FORMULA : ((((C8*1%)*25)/300)+(C8/300)*0,99)*12

    # OLD FORMULA : 
    #		annual_interest_rate = (total_acquisition * 1 / 100)
    #		lifetime_credit_interest = annual_interest_rate * 25
    #		monthly_credit_interest = lifetime_credit_interest / 300
    #		
    #		lifetime_credit_monthly_acquisition = total_acquisition / 300
    #		add_interest = lifetime_credit_monthly_acquisition * 0.99
    #		
    #		total = (monthly_credit_interest + add_interest) * MONTH
    #		
    #		puts "credit = #{total}"
    #		return total

    # NEW EXCEL FORMULA : =(-PMT((1+1,6%)^(1/12)-1;25*12;C8))*12

    #    nominal_rate = (1 + ((CREDIT_RATE * 1) / 100)) ** (1 / 12) - 1
    #    
    #    loan = FinanceMath::Loan.new(nominal_rate: nominal_rate, duration: duration, amount: total_acquisition)
    #    puts "credit : #{loan.pmt * MONTHS}"
    #    return loan.pmt * MONTHS

    puts "credit : #{menscredit} * 12 = #{menscredit * 12}"
    menscredit * 12   # this return the total credit to pay in the lifetime_credit 
  end

  def menscredit
    c = total_acquisition
    ia = investor_profile.credit_rate
    n = investor_profile.credit_years * MONTHS
    
    puts "menscredit(#{c}, #{ia}, #{n})"
    # si le capital est nul, il n'y a rien à rembourser
    if c == 0
      m = 0
      puts "credit if 1. m = #{m}"
      return m
    end
    # si l'intérêt est nul, la mensualité ne dépend plus que de C et N
    if ia == 0
      
      m = c / n
      puts "credit if 2. m = #{m}"
      return m
    end
    # calcul de la mensualité dans le cas général
    c = c
    i = ia / 1200
    m = c * i * (1-1/(1-(1+i)**n))
    puts "menscredit(#{c}, #{ia}, #{n}): mensualités #{m} d'un prêt #{c} à #{ia}% d'intérêt par an, à rembourser en #{n} mois"
    return m
  end

  def coownership_charges # C17
    # Formula before : 
    #	(monthly_charges / 2) * MONTH 
    puts "coownership_charges : #{annual_charges}"
    annual_charges
  end

  def house_insurance # C18
    120
  end

  def rent_insurance # C19
    total = ((2 * monthly_rent_estimation) / 100) * MONTHS
    puts "rent_insurance = #{total}"
    return total
  end

  def property_tax # C20
    puts "property_tax : #{monthly_rent_estimation * PROPERTY_TAXES}"
    monthly_rent_estimation * PROPERTY_TAXES
  end

  def administrative_management # C21
    total = (monthly_rent_estimation * ADMINISTRATIVE_MANAGMENT_RATE) * MONTHS
    puts "administrative_management = #{total}"
    return total
  end

  def credit_insurance # C22
    investor_profile.credit_insurance * investor_profile.number_of_investors
  end

  def various # C23
    0
  end

  def total_annual_fees # C24
    total = credit + coownership_charges + house_insurance + rent_insurance + property_tax + administrative_management + credit_insurance + various
    puts "total_annual_fees = #{total}"
    return total
  end

end
