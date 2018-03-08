class TestMailer < ApplicationMailer

  def welcome(email)
    @email = email
    @subject = "[SIGNON DEV APP] test mailer!"

    mail to: @email, subject: @subject
  end
end
