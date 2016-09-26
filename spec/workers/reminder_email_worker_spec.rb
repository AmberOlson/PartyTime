require 'sidekiq/testing'
Sidekiq::Testing.fake!

describe 'Reminder Email Worker' do

  it 'assert that jobs were pushed on to the queue' do
    expect { ReminderEmailWorker.perform_async(1, 2) }.to change(ReminderEmailWorker.jobs, :size).by(1)
  end

  it 'assert that jobs were pushed on to the queue 2' do
    assert_equal 0, ReminderEmailWorker.jobs.size
    ReminderEmailWorker.perform_async(1, 2)
    assert_equal 1, ReminderEmailWorker.jobs.size
  end

  it 'calls the correct number of jobs per number of users ' do
    event = FactoryGirl.create(:event)
    FactoryGirl.create(:user)
    FactoryGirl.create(:user, email: 'example2@email.com')
    FactoryGirl.create(:membership)
    FactoryGirl.create(:membership, user_id: 2)

    assert_equal 0, UserReminderEmailWorker.jobs.size
    ReminderEmailWorker.perform_async(event.id)
    ReminderEmailWorker.drain
    assert_equal 2, UserReminderEmailWorker.jobs.size

  end

end
