class RegistrationsController < Devise::RegistrationsController
  protected

   # To redirct users after sign-up to edit

  def after_sign_up_path_for(user)
    if current_user.freelancer
      edit_freelancer_path(user.freelancer.id)
    else
      edit_client_path(user.client.id)
    end
  end
end
