class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.invoice_to_client.subject
  #
  def send_invoice_client(invoice_id)
    @invoice = Invoice.find(invoice_id)

    # client email is saved in the object invoice
    @client_email = @invoice.client.email

    mail to: "to@example.org"
  end

end
