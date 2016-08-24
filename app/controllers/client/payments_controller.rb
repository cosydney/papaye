class PaymentsController < ApplicationController

  def create
    if @invoice.pay(params)
      redirect_to dashboard
    else
      redirect_to client_invoices_path(@invoice)
    end

  end

end
