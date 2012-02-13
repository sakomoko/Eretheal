class CharactersController < ApplicationController
  before_filter :login_or_oauth_required
  respond_to :html, :json, :xml

  def index
    @characters = current_user.characters
    respond_with @characters
  end

  def select
    @character = current_user.characters.find(params[:id])
    session[:character_id] = @character.id
    respond_with @character
  end
end
