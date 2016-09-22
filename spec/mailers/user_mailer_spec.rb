require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do

  describe 'sending welcome email to new users' do
    let(:user) { 'lucas@email.com' }
    let(:event) { Event.new(title: 'Party') }
    let(:membership) { Membership.new(id: 1) }
    let(:mail) { UserMailer.welcome_email(user, event, membership) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Welcome to My Awesome Site')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['from@example.com'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(user)
    end

    it 'assigns @event' do
      expect(mail.body.encoded).to match(event.title)
    end

    it 'assigns @confirmation_url' do
      expect(mail.body.encoded).to match('http://localhost/welcome')
    end
  end

  describe 'sending membership email to current users' do
    let(:user) { 'lucas@email.com' }
    let(:event) { Event.new(title: 'Party') }
    let(:mail) { UserMailer.membership_email(user, event) }

    it 'renders the subject' do
      expect(mail.subject).to eql('You have been invited to an event')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['from@example.com'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(user)
    end

    it 'assigns @event' do
      expect(mail.body.encoded).to match(event.title)
    end

    it 'assigns @confirmation_url' do
      expect(mail.body.encoded).to match('http://localhost/users/sign_in')
    end
end



    #describe 'sending reminder email to users about upcoming events' do
      #  let(:user) { 'lucas@email.com' }
      #  let(:event) { Event.new(title: 'Party', id: 1, lat: '43.6428836', lng: '-79.40251109999997') }
      #  let(:mail) { UserMailer.reminder_email(user, event) }

      #  it 'renders the subject' do
      #    expect(mail.subject).to eql('Your event is tomorrow')
      #  end

      #  it 'renders the receiver email' do
      #    expect(mail.to).to eql([user])
      #  end

      #  it 'renders the sender email' do
      #    expect(mail.from).to eql(['from@example.com'])
      #  end

      #  it 'assigns @name' do
      #    expect(mail.body.encoded).to match(user)
      #  end

      #  it 'assigns @event' do
      #    expect(mail.body.encoded).to match(event.title)
      #  end

      #  it 'assigns @confirmation_url' do
      #    expect(mail.body.encoded).to match('http://localhost/events/1')
      #  end

      #  it 'sets the location' do
      #    expect(mail.body.encoded).to match('Tomorrows temperature in Toronto')
      #  end

      #end

end
