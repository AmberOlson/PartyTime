class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def new
    @membership = Membership.where(:event_id => @event.id)
  end

  def create
    activated_ids = params[:activated].collect { |id| id.to_i }
    activated_ids.each do |id|
      Membership.update(id, :admin => true)
    end
    redirect_to @event
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

end
