class InvitationsController < Devise::InvitationsController
  def after_accept_path_for(user)
    client_invoices_path
  end
end
