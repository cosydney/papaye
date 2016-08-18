class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_invoice_client.subject
  #
  def send_invoice_client(invoice_id)
    # Instance variable => available in view
    @invoice = Invoice.find(invoice_id)

    # client email is saved in the object invoice
    @client_email = @invoice.client.email

    # Set fl (freelancer) name
    @fl_fist_name = @invoice.freelancer.first_name
    @fl_last_name = @invoice.freelancer.last_name
    @fl_name = "#{fl_fist_name} #{fl_last_name}"

    #render a view in app/views/user_email
    mail(to: @client_email, subject: "Invoice from #{fl_name}")
  end
end
