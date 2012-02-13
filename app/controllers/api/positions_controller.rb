class Api::PositionsController < ApplicationController
  before_filter :login_or_oauth_required
  respond_to :json, :xml
  def show
    @character = current_character
    respond_with @character, include: :user
  end
end
