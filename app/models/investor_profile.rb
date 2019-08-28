class InvestorProfile < ApplicationRecord
  
  # ============= Constants =================
  LEGAL_FORMS = ["sci_is", "sci_ir", "ir"]
  
  # ============= Relationships =============
  belongs_to :user
  
  # ============= Validations ===============
  validates :credit_years, numericality: { in: 1..50 }
  validates :credit_rate, numericality: { in: 0..100 }
  validates :credit_insurance, numericality: { greater_or_equal_than: 0 }
  validates :number_of_investors, numericality: { greater_or_equal_than: 1 }
  validates :legal_form, inclusion: { in: LEGAL_FORMS }
  validates :net_yield_limit, numericality: { greater_or_equal_than: 0 }
  
  # ============ Scopes =====================
  
end
