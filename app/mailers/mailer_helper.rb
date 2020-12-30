module MailerHelper
  def email_from
    "#{app_name} <#{email_from_address}>"
  end

  def email_to
    I18n.t("noisy_batch_invitation_mailer.to",
      reply_to_domain: reply_to_domain
    )
  end

  def app_name
    I18n.t("mailer.app_name",
      instance_name: instance_name
    )
  end

  def email_from_address
    if instance_name.present?
      I18n.t("mailer.email_from_address.instance",
        instance_name: instance_name.parameterize,
        reply_to_domain: reply_to_domain
      )
    else
      I18n.t("mailer.email_from_address.no-instance",
        reply_to_domain: reply_to_domain
      )
    end
  end

  def instance_name
    Rails.application.config.instance_name
  end

  def reply_to_domain
    ENV.fetch 'EMAIL_REPLY_TO_DOMAIN', 'digital.cabinet-office.gov.uk'
  end
end
