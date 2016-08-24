class FreelancersController < ApplicationController
  before_action :set_freelancer, only: [:edit, :update, :destroy]

  # Disalloww client to edit freelancer
  before_action :desauthorize_client, only:[:edit]


  def edit
  end

  def update
    respond_to do |format|
      if @freelancer.update(freelancer_params)
        format.html { redirect_to @freelancer, notice: 'Welcome Freelancer! You have been updated.' }
        format.json { render :show, status: :ok, location: @freelancer }
      else
        format.html { render :edit }
        format.json { render json: @freelancer.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
     @freelancer = current_user.freelancer
  end

  def destroy
  end

  private

  def set_freelancer
    @freelancer = current_user.freelancer
  end

  def freelancer_params
    params.require(:freelancer).permit(Freelancer.unprotected_attrs)
  end

  def desauthorize_client
    # If the current user is not a client, he gets redirected to the root page
    if current_user.client
      redirect_to root_path, alert: "You don't have the rights"
    end
  end
end
