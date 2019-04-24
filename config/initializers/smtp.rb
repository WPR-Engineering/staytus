if CONFIG[:EMAIL_SERVER][:ENABLED]
  puts "\e[33m=> Your email will be sent from #{CONFIG[:EMAIL_SERVER][:SMTP_HOST]}.\e[0m"
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address    => CONFIG[:EMAIL_SERVER][:SMTP_HOST],
    :port       => CONFIG[:EMAIL_SERVER][:SMTP_PORT],
    :user_name  => CONFIG[:EMAIL_SERVER][:SMTP_USER],
    :password   => CONFIG[:EMAIL_SERVER][:SMTP_PASSWORD]
  }
else
  puts "\e[33m=> You haven't configured an SMTP server. Mail will be sent using sendmail.\e[0m"
  ActionMailer::Base.delivery_method = :sendmail
end

Mail.defaults do
  if ActionMailer::Base.delivery_method == :smtp
    delivery_method :smtp, ActionMailer::Base.smtp_settings
  else
    delivery_method ActionMailer::Base.delivery_method
  end
end
