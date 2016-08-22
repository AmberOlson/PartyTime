class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:new, :create, :update]

  def new
    @user = current_user
    @membership = Membership.where(:event_id => @event.id, :user_id => @user.id).first
    @relationship = Relationship.where(:user_id => current_user)
    @classifications = [{:id => "classification_other", :class => "classification_other", :title => "Other:", :classification => Relationship::REL_OTHER},
                        {:id => "classification_friend", :class => "classification_friend", :title => "Friend:", :classification => Relationship::REL_FRIEND},
                        {:id => "classification_family", :class => "classification_family", :title => "Family:", :classification => Relationship::REL_FAMILY},
                        {:id => "classification_school", :class => "classification_school", :title => "School:", :classification => Relationship::REL_SCHOOL},
                        {:id => "classification_coworker", :class => "classification_coworker", :title => "Coworker:", :classification => Relationship::REL_COWORKER}
]
  end

  def create
    @userinvited = User.find_by(email: params[:user_email].downcase)
    @user = current_user

    if request.post?
      activated_emails = params[:activated].collect if params[:activated]

      if activated_emails
        activated_emails.each do |email|
          @friend = User.find_by_email(email)
          if !friend_of?(@event, @friend)
            make_membership()
            @membership.update_membership_attributes(@friend)
            UserMailer.membership_email(@friend.email, @event).deliver
          end
        end
      end
    end

    if @userinvited && !friend_of?(@event, @userinvited)
      make_membership()
      @membership.update_membership_attributes(@userinvited)
      @user.create_relationship(@userinvited)
      UserMailer.membership_email(@userinvited.email, @event).deliver
      #redirect_to event_path(@event)
      #return
    end

    if @userinvited
      flash[:notice] = "User already invited"
      redirect_to new_event_membership_path(@event)
      return
    end

    if !params[:user_email].blank?
      @newuser = params[:user_email].downcase
      make_membership()
      @membership.new_usermembership
      @membership.create_invitiation_token
      UserMailer.welcome_email(@newuser, @event, @membership).deliver
      flash[:notice] = "Email Sent"
    end

    redirect_to event_path(@event)
  end

  def update
    @membership = Membership.find(params[:id])

    if @membership.update(status: params[:status])
      #flash[:notice] = "You are now attending this event"
      #redirect_to @event
    respond_to do |format|
      format.html { redirect_to @event, notice: "You are now attending this event--test"}
      format.js
    end
    else
      flash[:notice] = "There was a problem adding you as going to this event"
      redirect_to @event
    end
  end

def destroy
  @membership = Membership.find(params[:id])
  @membership.destroy
  redirect_to user_path(current_user)
end


  private
  def membership_params
    params.require(:membership).permit(:admin, :status)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def make_membership
    @membership = @event.memberships.build
    @membership.save
  end

  def friend_of?(event, user)
      Membership.where(user_id: user.id, event_id: event.id).any?

  end


end
