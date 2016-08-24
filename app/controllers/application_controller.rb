class ApplicationController < ActionController::Base
  # newsfeed
  include PublicActivity::StoreController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  after_action :set_navbar

  def set_navbar
    @navbar ||= :left
  end

end
