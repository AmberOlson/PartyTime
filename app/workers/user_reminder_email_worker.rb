class UserReminderEmailWorker
  include Sidekiq::Worker

  def perform(user_id, event_id)

    event = Event.find(event_id)
    user = User.find(user_id)

    UserMailer.reminder_email(user.email, event).deliver
  end
  
end
