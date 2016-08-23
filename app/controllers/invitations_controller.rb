class InvitationsController < Devise::InvitationsController
  def after_accept_path_for(user)
    # Passing the last (and only) invoice id, to redirect to show
    client_invoice_path(current_user.client.invoices.last)
  end
end
