module RealEstatesHelper
  include ActionView::Helpers::NumberHelper
  
  def to_percentage(number)
    number_to_currency(number, unit: "%", separator: ",", delimiter: "", format: "%n %u")
  end
  
  def to_currency(number)
    number_to_currency(number, unit: "€", separator: ",", delimiter: "", format: "%n %u")
  end
end
