class UserDetailsController < ApplicationController
  
  def index
    @users = UserDetail.all
  end

  def new
    @user = UserDetail.new
  end

  def create
    @user = UserDetail.new(user_detail_params)
    if @user.save
      redirect_to user_details_path
    else
      render :new
    end
  end

private

  def user_detail_params
    params.require(:user_detail).permit(:id, :email, :pan_card, :adhar_card, :account_number, :account_ifsc, :mo_in_flow, :mo_out_flow)
  end
end
