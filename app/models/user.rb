class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # =================== Before/after ====================
  
  after_create :attach_investor_profile
  
  # =================== Relationships ===================
  
  has_many :real_estates
  has_one :investor_profile
  
  # =================== Devise Methods ==================
  
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
  
  # =================== After Create ====================
  
  def attach_investor_profile
    InvestorProfile.create!(user: self)
  end
  
end
