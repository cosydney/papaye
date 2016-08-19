class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @navbar = :top
    UserMailer.test_email.deliver_now
  end

  def signup
    @navbar =:top
  end
end
