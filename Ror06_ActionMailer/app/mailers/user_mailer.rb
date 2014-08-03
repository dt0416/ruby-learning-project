class UserMailer < ActionMailer::Base
  default from: "dt0416@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.confirm.subject
  #
  def confirm
    @greeting = "Hi"

    mail to: "dt0416@gmail.com"
  end
end
