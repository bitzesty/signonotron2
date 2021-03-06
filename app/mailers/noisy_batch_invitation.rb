class NoisyBatchInvitation < ApplicationMailer
  include MailerHelper

  default from: Proc.new { email_from }
  default to: Proc.new { email_to }

  def make_noise(batch_invitation)
    @user = batch_invitation.user
    @batch_invitation = batch_invitation

    user_count = batch_invitation.batch_invitation_users.count
    subject = "[SIGNON] #{@user.name} created a batch of #{user_count} users"
    subject << " in #{instance_name}" if instance_name
    view_mail(template_id, subject: subject)
  end
end
