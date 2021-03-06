class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:new, :create, :update]
  before_action :set_user, only: [:new, :create]

  def new
    @membership = Membership.where(event_id: @event.id, user_id: @user.id).first
    @relationship = Relationship.where(user_id: current_user)
    @classifications = [{ id: 'classification_other', class: 'classification_other', title: 'Other:', classification: Relationship::REL_OTHER },
                        { id: 'classification_friend', class: 'classification_friend', title: 'Friend:', classification: Relationship::REL_FRIEND },
                        { id: 'classification_family', class: 'classification_family', title: 'Family:', classification: Relationship::REL_FAMILY },
                        { id: 'classification_school', class: 'classification_school', title: 'School:', classification: Relationship::REL_SCHOOL },
                        { id: 'classification_coworker', class: 'classification_coworker', title: 'Coworker:', classification: Relationship::REL_COWORKER }]
  end

  def create
    @userinvited = User.find_by(email: params[:user_email].downcase)

    invite_friends(params[:activated].collect) if params[:activated]
    if @userinvited
      invite_a_user
    elsif !params[:user_email].blank?
      invite_a_new_user
    end
    redirect_to event_path(@event)
  end

  def update
    @membership = Membership.find(params[:id])

    if @membership.update(status: params[:status])
      respond_to do |format|
        format.html { redirect_to @event, notice: 'You are now attending this event--test' }
        format.js
      end
    else
      flash[:notice] = 'There was a problem adding you as going to this event'
      redirect_to @event
    end
  end

  def destroy
    Membership.find(params[:id]).destroy
    redirect_to user_path(current_user)
  end

  private

  def membership_params
    params.require(:membership).permit(:admin, :status)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_user
    @user = current_user
  end

  def make_membership(user)
    @membership = @event.memberships.build
    @membership.update_attributes(user_id: user.id)
    @membership.save
  end

  def member_of?(event, user)
    Membership.where(user_id: user.id, event_id: event.id).any?
  end

  def invite_friends(activated_membership_id)
    activated_membership_id.each do |id|
      @friend = User.find_by_id(Relationship.where(id: id).pluck(:friend_id))
      unless member_of?(@event, @friend)
        make_membership(@friend)
        UserMailer.membership_email(@friend.email, @event).deliver
      end
    end
  end

  def invite_a_user
    if !member_of?(@event, @userinvited)
      make_membership(@userinvited)
      @user.create_relationship(@userinvited)
      UserMailer.membership_email(@userinvited.email, @event).deliver
    else
      flash[:notice] = 'User already invited'
    end
  end

  def invite_a_new_user
    @newuser = params[:user_email].downcase
    @membership = @event.memberships.build
    @membership.create_invitiation_token
    UserMailer.welcome_email(@newuser, @event, @membership).deliver
    flash[:notice] = 'Email Sent'
  end

end
