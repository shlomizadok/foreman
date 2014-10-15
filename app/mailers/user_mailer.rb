class UserMailer < ApplicationMailer
  helper :reports

  default :content_type => "text/plain", :from => Setting[:email_reply_address] || "noreply@foreman.example.org"

  def welcome(options = {})
    user = options[:user]
    @login = user.login

    set_locale_for user

    mail(:to      => user.mail,
         :subject => _("Welcome to Foreman"),
         :date    => Time.now)
  end
end
