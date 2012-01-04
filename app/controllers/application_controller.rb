class ApplicationController < ActionController::Base
  protect_from_forgery
  alias :login_required :authenticate_user!
  alias :logged_in :user_signed_in?
end
