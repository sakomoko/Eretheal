class ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  alias :login_required :authenticate_user!
  alias :logged_in? :user_signed_in?
  respond_to :html, :json

  def current_user=(user)
    sign_in(user)
  end

  def current_character
    current_user.current_character
  end
end
