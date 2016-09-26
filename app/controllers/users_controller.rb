class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @events = Event.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User was successfully updated.'
      redirect_to @user
    else
      flash[:notice] = 'There was a problem editing your user profile.'
      render 'edit'
    end
  end

  def redirect_page
    membership = params[:membership_id]
    cookies[:membership_id] = { value: membership, expires: 1.year.from_now }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :picture)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
