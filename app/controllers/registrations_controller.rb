class RegistrationsController < Devise::RegistrationsController
  protected

   # To redirct users after sign-up to edit

  def after_sign_up_path_for(user)
    edit_freelancer_path(user.freelancer.id)
  end
end
