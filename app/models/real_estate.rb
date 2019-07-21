class RealEstate < ApplicationRecord
	
	# ============= Relationships =============
	
	belongs_to :user
	
	# ============= Validations ===============
	
	STATES = %w(created abandoned offline interested waiting_response visited financement_progress buyed)
	
	validates :ad_link, presence: true
	validates :buying_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validates :monthly_rent_estimation, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validates :annual_charges, presence: true, numericality: { greater_than_or_equal_to: 0 }
	validates :works_budget, numericality: { greater_than_or_equal_to: 0 }
	validates :furniture_budget, numericality: { greater_than_or_equal_to: 0 }
	validates :others_budget, numericality: { greater_than_or_equal_to: 0 }
	validates :state, presence: true, inclusion: { in: STATES }
	
	# ============ Scopes ===================
	
	scope :created, -> { where(state: "created") }
	scope :abandoned, -> { where(state: "abandoned") }
	scope :offline, -> { where(state: "offline") }
	scope :interested, -> { where(state: "interested") }
	scope :waiting_response, -> { where(state: "waiting_response") }
	scope :visited, -> { where(state: "visited") }
	scope :financement_progress, -> { where(state: "financement_progress") }
	scope :buyed, -> { where(state: "buyed") }
	scope :ordered_by_net_yield, -> (limit) { order(net_yield: :desc).limit(limit) }
	scope :ordered_by_annual_cashflow, -> (limit) { order(annual_cashflow: :desc).limit(limit) }
  scope :visible_by, -> (user) { where("user_id = ?", user.id) }
	
	def annual_rent_estimation
		monthly_rent_estimation * 12
	end
	
	def montly_charges
		annual_charges / 12
	end
	
	def monthly_cashflow
		annual_cashflow / 12
	end
  
  def abandoned?
    state == "abandoned" || state == "offline" || state == "buyed"
  end
  
  def abandonable_or_editable?
    !abandoned?
  end
	
end
