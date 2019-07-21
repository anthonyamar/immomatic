class RealEstatesController < ApplicationController
  def index
    @real_estates = RealEstate.visible_by(current_user)
  end
  
  def show
    @real_estate = RealEstate.find(params[:id])
  end
  
  def new
    
  end
  
  def create
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
  
  def real_estate_params
    
  end
  
end
