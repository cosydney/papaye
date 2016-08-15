class InvoicesController < ApplicationController

  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # TODO show the freelancer the dashboard (/) rootpath when logged-in (see routes)
  def index

  end

  # TODO create a new Invoice (new/create). After create redirect to index.
  def new

  end

  def create
    redirect_to dashboard_path
  end

  # TODO show a specific Invoice. link_to back, edit
  def show

  end

  # TODO edit an already existing Invoice (edit/update). Afterward redirect to index
  def edit

  end

  def update
    redirect_to dashboard_path
  end

  # TODO destroy a specific Invoice
  def destroy
    redirect_to dashboard_path
  end


  private

  def set_invoice
    @invoice = current_user.freelancer.invoices.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # def invoice_params
  #   # to set params, think about nested forms (need freelancer and client attributes!)
  #   params.require(:invoice).permit()
  # end

end
