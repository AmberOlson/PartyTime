require 'open-uri'
require 'json'


class UserMailer < ActionMailer::Base

    require 'mail'
Mail.defaults do
  delivery_method :smtp, { :address   => "smtp.sendgrid.net",
                           :port      => 587,
                           :domain    => "immense-basin-81929.herokuapp.com",
                           :user_name => "app56928747@heroku.com",
                           :password  => "wcbmbnsx7832",
                           :authentication => 'plain',
                           :enable_starttls_auto => true }
end

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
    mail(to: @user, subject: 'You have been invited to an event')
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
