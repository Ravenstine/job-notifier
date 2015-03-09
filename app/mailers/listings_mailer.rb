class ListingsMailer < ApplicationMailer
  default from: 'test@safetymail.info'
 
  def notify recipient_email, listing
    @listing = listing
    mail to: recipient_email, subject: listing.title
  end

end
