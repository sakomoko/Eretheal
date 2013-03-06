class Api::PositionsController < ApplicationController

  def go
    @manager = Eretheal::Manager.new current_character
    @manager.position.go params[:id]
    @manager.finish
    flash[:message] = @manager.messages
    redirect_to @manager.pc
  end

  def show
    @character = current_character
    respond_with @character, include: :user
  end
end
