class CharactersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @characters = current_user.characters
    respond_with @characters
  end

  def show
    @character = current_user.characters.find(params[:id])
    respond_with @character
  end

  def select
    @character = current_user.characters.find(params[:id])
    session[:character_id] = @character.id
    respond_with @character
  end
end
