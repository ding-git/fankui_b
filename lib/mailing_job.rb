class MailingJob < Struct.new(:mailing_id)
  def perform
    UserMailer.welcome_email.deliver
  end
end