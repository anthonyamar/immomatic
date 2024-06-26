class RealEstatesController < ApplicationController
  
  before_action :must_be_user_real_estate, only: [:show, :update, :destroy, :duplicate]
  
  def index
    @real_estates = RealEstate.visible_by(current_user)
  end
  
  def show
    @real_estate = RealEstate.find(params[:id]).decorate
    @profitability = CalcFile.new(@real_estate)
  end
  
  def new
    @real_estate = RealEstate.new
  end
  
  def create
    @real_estate = RealEstate.new(real_estate_params)
    
    respond_to do |format|
      if @real_estate.save
        format.html { redirect_to real_estate_path(@real_estate)}
        flash[:success] = "Votre bien immobilier a bien été répertorié"
      else
        format.html { render :new }
        @real_estate.errors.each do |attr, msg|
          flash[:danger] = msg
        end
      end
    end
  end

  def update
    @real_estate = RealEstate.find(params[:id])
    
    if @real_estate.update(real_estate_params)
      respond_to do |format|
      
        format.html { redirect_to real_estate_path(@real_estate) }
        flash[:success] = "Votre bien immobilier a bien été mis à jour"
      end
    else
      respond_to do |format|
        format.html { redirect_to real_estate_path(@real_estate) }
        @real_estate.errors.each do |attr, msg|
          flash[:danger] = msg
        end
      end
    end
  end
  
  def destroy
    @real_estate = RealEstate.find(params[:id])
    
    respond_to do |format|
      if @real_estate.destroy
        format.html { redirect_back(fallback_location: real_estates_path) }
        flash[:success] = "Votre bien immobilier a bien été supprimé"
      else
        format.html { redirect_back(fallback_location: real_estates_path) }
        @real_estate.errors.each do |attr, msg|
          flash[:danger] = msg
        end
      end
    end
  end
  
  def duplicate
    @real_estate = RealEstate.find(params[:id])
    duplicated_real_estate = @real_estate.dup
    
    respond_to do |format|
      if duplicated_real_estate.save
        format.html { redirect_back(fallback_location: real_estates_path) }
        flash[:success] = "Votre bien immobilier a bien été dupliqué"
      else
        format.html { render :new }
        @real_estate.errors.each do |attr, msg|
          flash[:danger] = msg
        end
      end
    end
  end
  
  private

  def real_estate_params
    params.require(:real_estate).permit(:ad_link, :buying_price, :monthly_rent_estimation, :annual_charges, :works_budget, :furniture_budget, :others_budget, :square_meters, :state, :others_annual_fees, :house_insurance, :property_tax, :address_street, :postal_code, :city, :country, :user_id)
  end

  def must_be_user_real_estate # before action
    real_estate = current_user.real_estates.find_by(id: params[:id])
    unless real_estate
      render_404
    end
  end
  
end
