class InvoicesController < ApplicationController

  before_action :set_invoice, only: [:show, :edit, :update, :destroy, :send_email, :edit_email]

  # TODO show the freelancer the dashboard (/) rootpath when logged-in (see routes)
  def index
    # redirect client to s/he's own dahsboard
    redirect_to client_invoices_path and return if current_user.client
    @invoices = Invoice.freelance_invoices(current_user)
    @activities = PublicActivity::Activity.where(owner: current_user).order(created_at: 'desc')
  end

  # TODO create a new Invoice (new/create). After create redirect to index.
  def new
    @disable_sidebars = true

    @invoice = Invoice.new
    @invoice.build_client
    @invoice.descriptions.build
    @user = User.new
    @client = Client.new
  end

  def edit_email
  end

  def send_email
    @user = User.where(email: @invoice.client.email).first
    if @user

      @invoice.send_invoice_by_email!(params[:text])
      current_user.freelancer.update(email_text: params[:text]) if params[:save] == '1'
    else
      @user = User.invite_client!({ email: @invoice.client.email }, current_user, {invoice_id: @invoice.id, content: params[:text]})
      @invoice.client.update(user_id: @user.id)
    end
    @invoice.transition_to("pending")
    redirect_to dashboard_path, notice: "Invoice sent to your client #{@invoice.client.first_name}!"
  end

  def create
    @client = Client.where(email: client_params[:email]).first
    @client ||= Client.new(client_params)

    if @client.save
      update_user_client

      @invoice = Invoice.create!(invoice_params.merge(freelancer_id: current_user.freelancer.id, client_id: @client.id))

      if params[:commit] == "Edit email & Send"
        redirect_to edit_email_invoice_path(@invoice), notice: 'Invoice saved'
      else
        redirect_to dashboard_path, notice: "Invoice has been saved waiting to be send"
      end
    else
      @disable_sidebars = true
      @invoice = Invoice.new(invoice_params)
      @invoice.valid?
      @user = User.new
      render :new
    end
  end

  # TODO show a specific Invoice. link_to back, edit
  def show
    @invoice = Invoice.find(params[:id])
    # redirect client to own invoice show
    redirect_to client_invoice_path(@invoice) and return if current_user.client

    #@total = (@invoice.descriptiond.unit  * @invoicce.descriptions.price ) + (@invoice.descriptions.unit * @invoice.descriptions.price * @invoice.descriptions.vat_tax / 100)

    # Create PDF
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "invoice_#{@invoice.invoice_nr}"   # Excluding ".pdf" extension.
      end
    end

  end

  # TODO edit an already existing Invoice (edit/update). Afterward redirect to index
  def edit
    @client = @invoice.client
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])

    # Need to do some refactoring here, but working!
    descriptions = invoice_params[:descriptions_attributes].select{ |k, v| v['_destroy'] == "false" }
    desc_arr_id = invoice_params[:descriptions_attributes].values.select{|h| h[:_destroy] == '1'}.map{|h| h[:id].to_i}
    @invoice.descriptions.where(id: desc_arr_id).destroy_all

    updated_invoice_params = invoice_params.merge!(descriptions_attributes: descriptions)

    @client = @invoice.client
    @client.update(client_params)

    # if @invoice.update(updated_invoice_params)
    #   redirect_to dashboard_path, notice: 'Invoice has been updated.'
    # else
    #   render :edit
    # end

    if params[:commit] == "Edit email & Send"
      redirect_to edit_email_invoice_path(@invoice), notice: 'Invoice saved'
    else
      redirect_to dashboard_path, notice: "Invoice has been saved waiting to be send"
    end

  end

  # TODO destroy a specific Invoice
  def destroy
    @id = @invoice.id
    @invoice.destroy
    @invoices = current_user.freelancer.invoices
    respond_to do |format|
      format.js
    end
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    # to set params, think about nested forms (need description and client attributes!)
    params.require(:invoice).permit(:invoice_date, :due_date, :invoice_nr, :invoice_terms, :project_description, descriptions_attributes: [:description, :amount, :unit, :vat_tax, :price, :id, :_destroy])
  end

  def client_params
    params.require(:client).permit(:first_name, :last_name, :company, :company_number, :email)
  end

  def update_user_client
    @user = User.where(email: client_params[:email]).first
    @client.update(user_id: @user.id) if @user
  end
end
