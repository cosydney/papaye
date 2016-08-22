class InvoicesController < ApplicationController

  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # TODO show the freelancer the dashboard (/) rootpath when logged-in (see routes)
  def index
    @invoices = Invoice.freelance_invoices(current_user)
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
    @invoice = Invoice.new(invoice_params.merge(freelancer_id: current_user.freelancer.id))

    if @client
      @invoice.client_id = @client.id
      @invoice.save
      UserMailer.send_invoice_client(@invoice.id).deliver_later
    else
      @client = Client.create(client_params)
      @invoice.client_id = @client.id
      @invoice.save
      User.invite_client!({email: client_params[:email]}, current_user, {invoice_id: @invoice.id})
    end

    update_user_client
    redirect_to dashboard_path, notice: 'Invoice saved!'
  end

  # TODO show a specific Invoice. link_to back, edit
  def show
    @invoice = Invoice.find(params[:id])
  end

  # TODO edit an already existing Invoice (edit/update). Afterward redirect to index
  def edit
    @client = @invoice.client
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    @client = @invoice.client
    @client.update(client_params)

    if @invoice.update(invoice_params)
      redirect_to dashboard_path, notice: 'Invoice has been updated.'
    else
      render :edit
    end
  end

  # TODO destroy a specific Invoice
  def destroy
    @invoice.destroy
    redirect_to dashboard_path
  end


  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    # to set params, think about nested forms (need description and client attributes!)
    params.require(:invoice).permit(:invoice_date, :due_date, :invoice_nr, :invoice_terms)
  end

  def client_params
    params.require(:client).permit(:first_name, :last_name, :company, :company_number, :email)
  end

  def update_user_client
    @user = User.where(email: client_params[:email]).first
    @client.update(user_id: @user.id) if @user
  end
end
