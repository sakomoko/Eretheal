class Api::CharactersController < ApplicationController
  before_filter :authenticate_user!
  def new
    @jobs = Job.all
    respond_with :api, @jobs
  end

  def create
    @character = Character.create do |d|
      d.user = current_user
      d.name = params[:character][:name]
      d.job_id = params[:character][:job_id]
      d.gender = params[:character][:gender].to_sym
    end
    current_user.current_character = @character
    current_user.save!
    respond_with :api, @character
  end

  def show
    @character = Character.find params[:id]
    respond_with :api, @character
  end
end
