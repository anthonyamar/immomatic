class RealEstatesController < ApplicationController
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
    respond_to do |format|
      if @real_estate.update(real_estate_params)
        format.html { redirect_to real_estate_path(@real_estate) }
        flash[:success] = "Votre bien immobilier a bien été mis à jour"
      else
        format.html { render :edit }
        @real_estate.errors.each do |attr, msg|
          flash[:danger] = msg
        end
      end
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private

  def real_estate_params
    params.require(:real_estate).permit(:ad_link, :buying_price, :monthly_rent_estimation, :annual_charges, :works_budget, :furniture_budget, :others_budget, :square_meters, :state, :address_street, :postal_code, :city, :country, :user_id)
  end

  def must_be_user_real_estate # before action
    real_estate = current_user.real_estate.find_by(id: params[:id])
    unless real_estate
      render_404
    end
  end
  
end
