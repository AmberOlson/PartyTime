require 'sidekiq/testing'
Sidekiq::Testing.fake!

describe "User Reminder Email Worker" do

  it "assert that jobs were pushed on to the queue" do
    expect {
      UserReminderEmailWorker.perform_async(1, 2)
    }.to change(UserReminderEmailWorker.jobs, :size).by(1)
  end

  it "assert that jobs were pushed on to the queue 2" do
    assert_equal 0, UserReminderEmailWorker.jobs.size
    UserReminderEmailWorker.perform_async(1, 2)
    assert_equal 1, UserReminderEmailWorker.jobs.size
  end

  xit "sends out email" do
    event = FactoryGirl.create(:event)
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:membership)
    UserReminderEmailWorker.perform_async(user.id, event.id)

    expect { UserReminderEmailWorker.drain }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

end
