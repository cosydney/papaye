class Client::InvoicesController < ApplicationController

  # before_action :authorize
  before_action :set_invoice, only: [:show]

  # TODO show the freelancer the dashboard (/) rootpath when logged-in (see routes)
  def index
    @invoices = current_user.client.invoices
  end

  # TODO show a specific Invoice. link_to back, edit
  def show

    # Create PDF
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "invoice #{@invoice.invoice_nr}"   # Excluding ".pdf" extension.
      end
    end
  end

  private

  def is_client?
    # returns an array, if is empty, there is no freelancer
    !!(current_user.client)
  end

  def authorize
    redirect_to dashboard_path, alert: "You don't have the rights" unless is_client?
  end

  def set_invoice
    @invoice = current_user.client.invoices.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    # to set params, think about nested forms (need description and client attributes!)
    params.require(:invoice).permit(:invoice_date, :due_date, :invoice_nr, :invoice_terms)
  end

end
