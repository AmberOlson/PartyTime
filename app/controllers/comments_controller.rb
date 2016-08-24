class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_event

    def create
      @comment = @event.comments.build(comment_params)
      @comment.user_id = current_user.id
      @user = current_user
      if @comment.save
        redirect_to event_path(@event)
      else
        flash[:notice] = "Error, comment must be longer than 2 letters"
        redirect_to event_path(@event)
      end
    end

  def destroy
    @event.comments.find(params[:id]).destroy
    redirect_to event_path(@event)
  end

  private
    def comment_params
      params.require(:comment).permit(:text, :user_id, :event_id)
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

end
