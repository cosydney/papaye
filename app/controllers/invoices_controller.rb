class InvoicesController < ApplicationController

  # before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # TODO show the freelancer the dashboard (/) rootpath when logged-in (see routes)
  def index
    @invoices = Invoice.all
  end

  # TODO create a new Invoice (new/create). After create redirect to index.
  def new
    @disable_sidebars = true

    @invoice = Invoice.new
    @invoice.build_client
    @user = User.new
  end

  def create
    @client = Client.where(company: client_params[:company], company_number: client_params[:company_number]).first
    # Create new client if the var @client is nil (||=)
    @client ||= Client.create(client_params)

    @user = User.where(email: client_params[:email]).first
    @client.update(user_id: @user.id) if @user

    @invoice = Invoice.new(invoice_params.merge(client_id: @client.id))

    if @invoice.save
      # To do some flash stuff!
      @disable_sidebars = false
      redirect_to dashboard_path, notice: 'Invoice saved!'
    else
      @disable_sidebars = true
      render :new
    end

  end

  # TODO show a specific Invoice. link_to back, edit
  def show
    @invoice = Invoice.find(params[:id])
  end

  # TODO edit an already existing Invoice (edit/update). Afterward redirect to index
  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])

    if @invoice.update(invoice_params)
      redirect_to dashboard_path, notice: 'Invoice has been updated.'
    else
      render :edit
    end
  end

  # TODO destroy a specific Invoice
  def destroy
    redirect_to dashboard_path
  end


  private

  def set_invoice
    @invoice = current_user.invoices.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    # to set params, think about nested forms (need description and client attributes!)
    params.require(:invoice).permit(:invoice_date, :due_date, :invoice_nr, :invoice_terms)
  end

  def client_params
    params.require(:client).permit(:first_name, :last_name, :company, :company_number, :email)
  end
end
