class ReminderEmailWorker
  include Sidekiq::Worker

  def perform(event_id)

    event = Event.find(event_id)

    event.users.all.each do |user|
      UserReminderEmailWorker.perform_async(user.id, event.id)
    end
  end

end
