class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def new
    @membership = Membership.where(:event_id => @event.id)
  end

  def create
    #if request.post?
      activated_ids = params[:activated].collect {|id| id.to_i} if params[:activated]
     # seen_ids = params[:seen].collect {|id| id.to_i} if params[:seen]

      #if seen_ids
        activated_ids.each do |id|
          r = Membership.find_by_id(id)
          r.update_attribute(:admin, true)
          r.save
        end
     # end
    #end
    redirect_to @event
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

end
