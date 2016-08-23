class ClientsController < ApplicationController
  before_action :set_client, only: [:edit, :update, :destroy]

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
end


