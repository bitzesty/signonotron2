class TestMailer < ActionMailer::Base
  include MailerHelper

  default from: Proc.new { email_from }

  def welcome(email)
    @email = email
    @subject = "[SIGNON DEV APP] test mailer!"

    mail to: @email, subject: @subject
  end
end
