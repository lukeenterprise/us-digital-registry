class NotificationMailer < ActionMailer::Base
  default from: "US Digital Registry <digitalregistry@usa.gov>",
    reply_to: "US Digital Registry Team <usdigitalregistry@gsa.gov>"
  Rails.logger.info "Notification Mailer"
  def email(notification)
    @notification = notification
    subject = "U.S. Digital Registry"
    if (@notification.item_type != "User")
       subject = "#{t(@notification.item.class)} has been #{@notification.message_type}"
    else (@notification.item_type == "User") 
       subject = "Your U.S. Digital Registry account has been activated"
    end
    body = "#{@notification.message}"   
    mail(:to => @notification.user.email, :subject => subject) do |format|
    format.html {
      render "body"
    }
    end
  end
end
