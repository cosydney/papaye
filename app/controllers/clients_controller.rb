class ClientsController < ApplicationController
  before_action :set_client, only: [:edit, :update, :destroy]
  # Disalloww client to edit freelancer
  before_action :desauthorize_client, only:[:edit, :index]

  def edit
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Welcome! You have been updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
     @client = current_user.client
  end

  def destroy
  end

  private

  def set_client
    @client = current_user.client
  end

  def client_params
    params.require(:client).permit(client.unprotected_attrs)
  end

  def desauthorize_client
    # If the current user is not a freelancer, he gets redirected to the root page
    # Or shoud the freelancer be able to edir the client?
    unless current_user.client
      redirect_to dashboard_path , alert: "You don't have the rights"
    end
  end
end


