# Create Invite Mailer that inherits from DeviseMailer and rewrite the invitation instructions mailer method
class InviteMailer < Devise::Mailer
  def invitation_instructions(record, token, options={})
    @invoice = Invoice.where(id: options[:invoice_id]).first
    @content = options[:content]
    # if invoice is nil, it's because something went wrong
    return nil unless @invoice
    @token = token

    # Client email is saved in the object invoice
    @client_email = @invoice.client.email

    # Set freelancer (fl) name
    @fl_first_name = @invoice.freelancer.first_name
    @fl_last_name = @invoice.freelancer.last_name
    @fl_name = "#{@fl_first_name} #{@fl_last_name}"

    devise_mail(record, record.invitation_instructions || :invitation_instructions, options)
  end
end
