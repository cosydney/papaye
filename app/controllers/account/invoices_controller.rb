class Account::InvoicesController < ApplicationController

  before_action :authorize, only: [:new, :create, :edit, :update]
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # TODO show the freelancer the dashboard (/) rootpath when logged-in (see routes)
  def index
    @invoices = current_user.freelancer.invoices
  end

  # TODO create a new Invoice (new/create). After create redirect to index.
  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  # TODO show a specific Invoice. link_to back, edit
  def show
  end

  # TODO edit an already existing Invoice (edit/update). Afterward redirect to index
  def edit
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  # TODO destroy a specific Invoice
  def destroy
    redirect_to dashboard_path
  end


  private

  def is_freelancer?
    # returns an array, if is empty, there is no freelancer
    freelancer = Freelancer.where(user_id: current_user.id)
    #reverse logic, if empty = true, then !freelancer
    !(freelancer.empty?)
  end

  def authorize
    redirect_to dashboard_path, alert: "You don't have the rights" unless is_freelancer
  end

  def set_invoice
    @invoice = current_user.invoices.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    # to set params, think about nested forms (need description and client attributes!)
    params.require(:invoice).permit(:invoice_date, :due_date, :invoice_nr, :invoice_terms)
  end

end
