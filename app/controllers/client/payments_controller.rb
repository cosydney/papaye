class Client::PaymentsController < ApplicationController
before_action :set_invoice

  def create
    if @invoice.pay(params)
      redirect_to dashboard_path
    else
      redirect_to client_invoices_path(@invoice)
    end
  end

private

def set_invoice
  @invoice = Invoice.find(params[:invoice_id])
end

end
