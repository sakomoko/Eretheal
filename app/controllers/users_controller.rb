class UsersController < ApplicationController

  before_filter :login_or_oauth_required

  def show
    pp 'hoge'
  end

end
