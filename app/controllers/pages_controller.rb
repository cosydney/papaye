class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @navbar = :top
  end

  def signup
    @navbar =:top
  end

  def contact

  end
end
