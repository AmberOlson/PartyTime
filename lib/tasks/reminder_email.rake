desc "Send an email to users reminding them the day before the event"

task :reminder_email => :environment do
  puts "Remind users of their upcoming event"
  Event.where(date: (Time.now.midnight)..Time.now.midnight + 1.day).all.each do |event|
    ReminderEmailWorker.perform_async(event.id)
  end
  ConfirmationMailer.confirmation_email().deliver
  puts "done."
end
