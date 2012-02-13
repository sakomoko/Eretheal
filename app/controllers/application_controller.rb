class ApplicationController < ActionController::Base
  protect_from_forgery
  alias :login_required :authenticate_user!
  alias :logged_in? :user_signed_in?

  def current_user=(user)
    sign_in(user)
  end

  def current_character
    return @character if @character
    if session[:character_id]
      @character = current_user.characters.find(session[:character_id])
    elsif current_token
      @character = current_token.character
    end
  end
end
