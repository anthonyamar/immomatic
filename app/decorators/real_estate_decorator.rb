class RealEstateDecorator < Draper::Decorator
  delegate_all
  include ActionView::Helpers::NumberHelper
  
  def format_buying_price
    to_currency(real_estate.buying_price)
  end
  
  def format_square_meters
    real_estate.square_meters.to_s + "m2"
  end
  
  def format_price_per_square_meters
    to_currency((real_estate.buying_price / real_estate.square_meters)) + "/m2"
  end
  
  def format_monthly_rent_estimation
    to_currency(real_estate.monthly_rent_estimation)
  end
  
  def format_annual_charges
    to_currency(real_estate.annual_charges)
  end
  
  def format_net_yield
    net_yield = calc_file.net_yield
    "#{color_number(net_yield.round(2), false)}".html_safe
  end
  
  def format_works_budget
    color_number(real_estate.works_budget)
  end
  
  def format_furniture_budget
    color_number(real_estate.furniture_budget)
  end
  
  def format_others_budget
    color_number(real_estate.others_budget)
  end
  
  def format_annual_cashflow
    annual_cashflow = calc_file.annual_cashflow_after_taxes
    "#{color_number(annual_cashflow)}".html_safe
  end
  
  def format_total_acquisition
    total_acquisition = calc_file.total_acquisition
    "#{color_number(total_acquisition)}".html_safe
  end
  
  def format_total_rent_revenues
    annual_rent_revenues = calc_file.total_rent_revenues
    "#{color_number(annual_rent_revenues)}".html_safe
  end
  
  def calc_file
    CalcFile.new(real_estate)
  end
  
  def format_states
    case state
      when "created"
      "<span class='text-info'>Repertorié</span>".html_safe
      when "abandoned"
      "<span class='text-danger'>Abandonné</span>".html_safe
      when "offline"
      "<span class='text-danger'>Annonce hors ligne</span>".html_safe
      when "interested"
      "<span class='text-success'>Intéressé</span>".html_safe
      when "waiting_response"
      "<span class='text-warning'>En attente de réponse</span>".html_safe
      when "visited"
      "<span class='text-info'>Visité</span>".html_safe
      when "financement_progress"
      "<span class='text-primary'>En financement</span>".html_safe
      when "buyed"
      "<span class='text-success'>Acheté</span>".html_safe
    end
  end
  
  def color_number(number, currency = true)
    number_currency = to_currency(number)
    percentage = "#{number.round(2)}%"
    total = currency ? number_currency : percentage
    if number > 0
      "<span class='text-success'>#{total}</span>".html_safe
    elsif number == 0
      "<span class='text-warning'>#{total}</span>".html_safe
    else
      "<span class='text-danger'>#{total}</span>".html_safe
    end
  end
  
  def to_currency(number)
    number_to_currency(number, unit: "€", separator: ",", delimiter: " ", format: "%n %u")
  end

end
