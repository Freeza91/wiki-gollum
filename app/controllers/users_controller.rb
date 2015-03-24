class UsersController < ApplicationController

  def home
  end

  def callback
    auth = JSON.parse(request.env["omniauth.auth"].to_json)
    if User.authenize(auth)
      redirect_to wikis_path
    else
      redirect_to root_path
    end
  end

end
