class InvestorProfilesController < ApplicationController
  
  before_action :must_be_user_investor_profile
  
  def edit
    @user = current_user
    @investor_profile = InvestorProfile.find(params[:id])
  end

  def update
    @investor_profile = InvestorProfile.find(params[:id])

    if @investor_profile.update(investor_profile_params)
      respond_to do |format|

        format.html { redirect_to edit_investor_profile_path(@investor_profile) }
        flash[:success] = "Votre bien immobilier a bien été mis à jour"
      end
    else
      respond_to do |format|
        format.html { render :edit }
        @investor_profile.errors.each do |attr, msg|
          flash[:danger] = msg
        end
      end
    end
  end
  
  private

  def investor_profile_params
    params.require(:investor_profile).permit(:credit_years, :credit_rate, :credit_insurance, :number_of_investors, :legal_form, :net_yield_limit)
  end

  def must_be_user_investor_profile # before action
    investor_profile = current_user.investor_profile
    unless investor_profile
      render_404
    end
  end

end
