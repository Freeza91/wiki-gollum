# encoding: utf-8

class UsersController < ApplicationController

  def home
  end

  def callback
    auth = JSON.parse(request.env["omniauth.auth"].to_json)
    @current_user = User.authenize(auth)
    if current_user
      session[:id] = @current_user.id
      flash['notice'] = '成功登陆'
      redirect_to wikis_path
    else
      flash['error'] = '用户名或密码不正确'
      redirect_to root_path
    end
  end

  def delete
    reset_session
    flash['notice'] = '成功登出'
    redirect_to root_path
  end

end
