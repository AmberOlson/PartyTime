class EventsController < ApplicationController
  before_action :authenticate_user!

  def show
    @event = Event.find(params[:id])
    @user = current_user
    @membership = Membership.where(:event_id => @event.id, :user_id => @user.id).first
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
    @user = current_user
    @membership = Membership.where(:event_id => @event.id, :user_id => @user.id).first
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      @user = current_user
      @event.create_admin_membership(@user)
      flash[:notice] = "Event successfully created"
      redirect_to @event
    else
      flash[:notice] = "There was a problem adding the event."
      render action: :new
    end
  end

  def update
    @event = Event.find(params[:id])
    @user = current_user
    @membership = Membership.where(:event_id => @event.id, :user_id => @user.id).first

    if @event.update(event_params)
      flash[:notice] = "Event was successfully updated."
      redirect_to @event
    else
      flash[:notice] = "There was a problem editing the event."
      render 'edit'
    end
  end

  def destroy
   @event = Event.find(params[:id])
   @event.destroy


   redirect_to user_path(current_user)
  end


  private
  def event_params
    params.require(:event).permit(:title, :street_number, :route, :city, :provence, :country, :postal_code, :lat, :lng, :date, :time, :description)
  end

end
