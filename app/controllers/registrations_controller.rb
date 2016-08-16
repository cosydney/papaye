class RegistrationsController < ApplicationController
  protected

   # To redirct users after sign-up to edit

  def after_sign_up_path_for(user)
    if current_user.freelancer
      'freelancer/edit'
    else
      'client/edit'
    end
  end
end
