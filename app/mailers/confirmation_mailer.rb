class ConfirmationMailer < ActionMailer::Base
  default from: "from@example.com"

  def confirmation_email()
    mail(to: "amberolson@trentu.ca", subject: 'Whenever success')
 end
end
