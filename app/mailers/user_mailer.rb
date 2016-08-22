class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.invoice_to_client.subject
  #

  # TODO welcoming users :)
  def welcome

  end

  def edit_email_tbs
  end


  def send_invoice_client(invoice_id, text)
    # text to be edited from freelancer
    @text = text

    @invoice = Invoice.find(invoice_id)

    # Client email is saved in the object invoice
    @client_email = @invoice.client.email

    # Set freelancer (fl) name
    @fl_first_name = @invoice.freelancer.first_name
    @fl_last_name = @invoice.freelancer.last_name
    @fl_name = "#{@fl_first_name} #{@fl_last_name}"

    # Render a view in app?views?user_email
    mail(to: @client_email, subject: "Invoice from #{@fl_name}")
  end

end
