require 'open-uri'
require 'json'

class UserMailer < ActionMailer::Base

  default from: 'from@example.com'

  def welcome_email(user, event, membership)
    @user = user
    @event = event
    @membership = membership
    mail(to: @user, subject: 'Welcome to My Awesome Site')
  end

  def membership_email(user, event)
    @user = user
    @event = event
    #mail(to: @user, subject: 'You have been invited to an event')

    RestClient.post "https://api:api:key-52542e3e32bb2ce0bc90532a295b68f4"\
    "@api.mailgun.net/v3/YOUR_DOMAIN_NAME/messages",
    :from => "PartyTime <postmaster@sandboxa57f7da321ce41bf9aba1a361c67ca86.mailgun.org>",
    :to => @user,
    :subject => 'You have been invited to an event',
    :text => "Testing some Mailgun awesomness!"
  end


  def reminder_email(user, event)
    @user = user
    @event = event
    parsed_json = weather(@event.lat, @event.lng)
    @temp_f = parsed_json['forecas']['txt_forecast']['forecastday'][2]['fcttext']
    mail(to: @user, subject: 'Your event is tomorrow')
  end

  def weather(lat, lng)
    open('http://api.wunderground.com/api/YOURKEY/forecast/q/' + lat + ',' + lng + '.json') do |f|
      # weatherunderground key has been deactivated
      json_string = f.read
      parsed_json = JSON.parse(json_string)
      return parsed_json
    end
  end

end
