require 'sidekiq/testing'
require 'rake'

# load File.expand_path('../../../lib/tasks/reminder_email.rake', __FILE__)

Sidekiq::Testing.fake!

describe 'rake reminder email task helper' do

  before do
    Rails.application.load_tasks
    Rake::Task.define_task(:environment)
  end

  it 'calls background jobs for events in the correct time frame' do

    t = Time.now
    FactoryGirl.create(:event)
    FactoryGirl.create(:event, title: 'now', date: t)
    # FactoryGirl.create(:event, date: t + (60 * 60 * 23))
    FactoryGirl.create(:event, title: 'now +24h', date: t + (60 * 60 * 24))
    FactoryGirl.create(:event, date: t + (60 * 60 * 27))
    FactoryGirl.create(:event, date: t + (60 * 60 * 48))
    FactoryGirl.create(:event, date: t + (60 * 60 * 70))
    FactoryGirl.create(:event, title: 'now -24h', date: t - 2_592_000)

    assert_equal 0, ReminderEmailWorker.jobs.size
    expect { Rake::Task['reminder_email'].invoke }.to change { ActionMailer::Base.deliveries.count }.by(1)
    assert_equal 2, ReminderEmailWorker.jobs.size
  end

  # it 'sends out the confiermation email to tell me that whenever sucessfully called the rake task' do
  #  expect {Rake::Task['reminder_email'].invoke }.to change { ActionMailer::Base.deliveries.count }.by(1)
  # end

end
