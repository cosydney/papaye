class FreelancersController < ApplicationController
  before_action :set_freelancer, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    respond_to do |format|
      if @freelancer.update(freelancer_params)

<<<<<<< HEAD
        format.html { redirect_to @freelancer, notice: 'Welcome Freelancer! You have been updated.' }
=======
        format.html { redirect_to @freelancer, notice: 'Freelancer was successfully updated.' }
>>>>>>> 1cae3e41df04cc0ecf06efd8cf18cec66d90245f
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
      # here the photos need to be at the end for some mystic reasons
      params.require(:freelancer).permit(Freelancer.unprotected_attrs)
    end
end
